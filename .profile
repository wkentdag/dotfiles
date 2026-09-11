# dependencies
_node_env="$HOME/.node-env"
if [ ! -r "$_node_env" ] && [ -L "$HOME/.profile" ]; then
  _profile_target=$(readlink "$HOME/.profile")
  _node_env="${_profile_target%/*}/.node-env"
fi
[ -r "$_node_env" ] && source "$_node_env"
unset _node_env _profile_target
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
compare() { gh pr create --web --base "${1:-main}"; }

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
  eval $(op signin hashicorp)
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
