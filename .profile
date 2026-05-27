# dependencies
# source ~/.git-completion.sh
# source ~/.git-prompt.sh
eval "$(thefuck --alias)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# prompt
# PS1='⚡️ \[\e[0;31m\]${PWD##*/}\[\e[m\]$(__git_ps1 "@\[\e[0;33m\]%s\[\e[m\]") ~ '
PS1='⚡️ %~  ~ '

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
alias compare="gh pr create --web"

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

# squashes the current changes into the previous commit
fixup() {
  local OC=`git rev-parse HEAD`
  git add -A
  git commit --fixup=$OC
  git rebase -i --autosquash $OC~1
}

# pushes the branch you are on and opens compare on github for a PR
pushpr() {
  git push -u origin `git rev-parse --abbrev-ref HEAD`
  git compare
}

# to be run after `npm version`, pushes tags, publishes, and opens release notes
publish(){
  push && push --tags && npm publish .
  echo `git config --get remote.origin.url` | sed -e 's/\.git/\/releases/g' | echo "`cat -`/new?tag=`git describe`" | xargs open
}

# node
alias reload-deps="rm -rf node_modules && npm i"

# autocomplete
# __git_complete co _git_checkout
# __git_complete push _git_push

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# postgres
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# go
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# history
export HISTSIZE=10000

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


# npm
# Node via nvm; pnpm via Corepack (reads packageManager from each repo's package.json).
# Corepack is re-enabled after every `nvm use` so pnpm tracks the active Node version.
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

_corepack_enable() {
  if command -v corepack; then
    corepack enable
  fi
}

# wrap nvm in a zsh-compatible way
if [[ -n "$ZSH_VERSION" && -n "$functions[nvm]" ]]; then
  functions[_nvm]="$functions[nvm]"
  nvm() {
    _nvm "$@"
    local ret=$?
    if [[ "$1" == "use" && $ret -eq 0 ]]; then
      _corepack_enable
    fi
    return $ret
  }
fi

_corepack_enable