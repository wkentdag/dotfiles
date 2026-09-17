# dependencies
eval "$(/opt/homebrew/bin/brew shellenv)"
source ~/.git-prompt.sh
if [[ -n "$ZSH_VERSION" ]]; then
  # Use git's zsh wrapper; sourcing the bash script prints a deprecation warning.
  _git_core=""
  for _d in \
    /Library/Developer/CommandLineTools/usr/share/git-core \
    /Applications/Xcode.app/Contents/Developer/usr/share/git-core
  do
    if [[ -f "$_d/git-completion.zsh" && -f "$_d/git-completion.bash" ]]; then
      _git_core="$_d"
      break
    fi
  done
  if [[ -n "$_git_core" ]]; then
    mkdir -p "$HOME/.zsh"
    ln -sf "$_git_core/git-completion.zsh" "$HOME/.zsh/_git"
    fpath=("$HOME/.zsh" $fpath)
    zstyle ':completion:*:*:git:*' script "$_git_core/git-completion.bash"
    autoload -Uz compinit && compinit
  fi
  unset _git_core _d
else
  source ~/.git-completion.sh
fi
command -v thefuck >/dev/null && eval "$(thefuck --alias)"

# prompt
if [[ -n "$ZSH_VERSION" ]]; then
  setopt PROMPT_SUBST
  export GIT_PS1_SHOWCOLORHINTS=1
  precmd() {
    __git_ps1 '⚡️ %F{red}${PWD:t}%f' ' ~ ' '@%s'
  }
else
  PS1='⚡️ \[\e[0;31m\]${PWD##*/}\[\e[m\]$(__git_ps1 "@\[\e[0;33m\]%s\[\e[m\]") ~ '
fi

# general
alias no="notify"
alias ls="ls -c1"
alias la="ls -a"
alias ll="ls -lahG"
alias reload="exec $SHELL -l"
alias profile="vim ~/.profile"
alias p="echo ''; cd ~/Documents/code; ls -c1; echo '';"
alias desktop="cd ~/Desktop"
alias server="python -m SimpleHTTPServer"
alias wifi="wifi-password"
alias bitly="bitly-client"
alias hf="history -10000 | fzf"

# git
alias co="git checkout"
alias s="echo ''; git status -sb; echo ''"
alias c="git commit"
alias stage="git add "
alias pull="git pull"
alias pullr="git pull -r"
alias push="git push"
alias ri="git rebase -i"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias d="git diff"
alias b="git branch"
alias amend="git commit --amend -m"
alias clone="git clone"
alias opr="gh pr view --web"
alias lg="lazygit"
compare() { gh pr create --web --base "${1:-main}"; }
pushn() { git push --set-upstream origin "$(git branch --show-current)"; }

# List extra worktrees: folder, branch, KEEP/SAFE. Prints remove commands for SAFE ones.
worktree-inventory() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "not a git repository" >&2
    return 1
  fi

  local main rows wt folder branch dirty upstream unpushed kind reason
  local red green yellow reset
  local remove_cmd="" count=0

  if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    red=$'\033[31m'
    green=$'\033[32m'
    yellow=$'\033[33m'
    reset=$'\033[0m'
  else
    red="" green="" yellow="" reset=""
  fi

  main="$(git rev-parse --show-toplevel)" || return

  while IFS= read -r wt; do
    [ -n "$wt" ] || continue
    [ "$wt" = "$main" ] && continue

    folder="${wt##*/}"
    branch="$(git -C "$wt" rev-parse --abbrev-ref HEAD)"
    dirty="$(git -C "$wt" status --porcelain)"
    upstream="$(git -C "$wt" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"

    if [ -n "$dirty" ]; then
      kind=KEEP
      reason="uncommitted changes"
    elif [ -z "$upstream" ]; then
      kind=KEEP
      reason="no upstream"
    else
      unpushed="$(git -C "$wt" rev-list --count '@{u}'..HEAD)"
      if [ "$unpushed" -gt 0 ]; then
        kind=KEEP
        reason="${unpushed} unpushed commit(s)"
      else
        kind=SAFE
        reason="clean and pushed"
        remove_cmd="${remove_cmd}git worktree remove -- $(printf '%q' "$wt")"$'\n'
      fi
    fi

    rows="${rows}${folder}"$'\t'"${branch}"$'\t'"${kind}"$'\t'"${reason}"$'\n'
    count=$((count + 1))
  done <<EOF
$(git worktree list --porcelain | sed -n 's/^worktree //p')
EOF

  echo ""
  if [ "$count" -eq 0 ]; then
    echo "no extra worktrees"
    echo ""
    return 0
  fi

  printf '%s' "$rows" | awk -F '\t' -v red="$red" -v green="$green" -v yellow="$yellow" -v reset="$reset" '
    {
      f[NR] = $1
      b[NR] = $2
      k[NR] = $3
      r[NR] = $4
      if (length($1) > wf) wf = length($1)
      if (length($2) > wb) wb = length($2)
    }
    END {
      if (length("folder") > wf) wf = length("folder")
      if (length("branch") > wb) wb = length("branch")
      printf "%-*s  %-*s  %s\n", wf, "folder", wb, "branch", "status"
      for (i = 1; i <= NR; i++) {
        fc = red
        bc = (b[i] == "HEAD") ? red : green
        if (k[i] == "SAFE") sc = green
        else if (r[i] == "uncommitted changes") sc = red
        else sc = yellow
        printf "%s%-*s%s  %s%-*s%s  %s%s%s  %s\n", \
          fc, wf, f[i], reset, bc, wb, b[i], reset, sc, k[i], reset, r[i]
      }
    }
  '

  echo ""
  if [ -n "$remove_cmd" ]; then
    echo "# Run from the main worktree to remove SAFE worktrees:"
    printf '%s' "$remove_cmd"
  else
    echo "no SAFE worktrees"
  fi
  echo ""
}

# recursively list files in directory by type
# https://unix.stackexchange.com/questions/18506/recursive-statistics-on-file-types-in-directory
function filestat() {
  find "$@" -type f | sed 's/.*\.//' | sort | uniq -c
}

# creates a new directory h/t http://bit.ly/2a9SPBi
function mk() {
  mkdir -p "$@" && cd "$@"
}

function 1pw() {
  eval $(op signin)
}

# autocomplete
if [[ -n "$ZSH_VERSION" ]]; then
  compdef _git co
  compdef _git push
else
  __git_complete co _git_checkout
  __git_complete push _git_push
fi

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# postgres
export PGDATA='/opt/homebrew/var/postgresql@16'
export PGHOST=localhost
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# go
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# history
export HISTSIZE=10000

# cursor / agent
export PATH="$HOME/.local/bin:$PATH"

# Music
flac2mp3() {
  FOLDER=$(dirname "$@")

  for FILE in "$FOLDER"/*.flac
  do
    FILENAME=$(basename "$FILE" .flac)
    echo "$FILENAME"	
    ffmpeg -i "$FILE" -ab 320k -map_metadata 0 -id3v2_version 3 "${FOLDER}/${FILENAME}.mp3"
  done
}

starsync() {
  FILE="${1:-$HOME/Desktop/sync.txt}"
  rsync -azvPr --files-from="$FILE" stardust:files "$HOME/Music/Music/Media.localized/Music"
}

# Load nvm last so it stays ahead of Homebrew and ~/.local/bin on PATH.
_node_env="$HOME/.node-env"
if [ ! -r "$_node_env" ] && [ -L "$HOME/.profile" ]; then
  _profile_target=$(readlink "$HOME/.profile")
  _node_env="${_profile_target%/*}/.node-env"
fi
[ -r "$_node_env" ] && source "$_node_env"
unset _node_env _profile_target

