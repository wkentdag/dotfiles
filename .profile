# dependencies
source ~/.git-completion.sh
source ~/.git-prompt.sh
eval "$(hub alias -s)"
eval "$(thefuck --alias)"

# prompt
PS1='⚡️ \[\e[0;31m\]${PWD##*/}\[\e[m\]$(__git_ps1 "@\[\e[0;33m\]%s\[\e[m\]") ~ '

# general
alias no="notify"
alias ls="ls -c1"
alias la="ls -a"
alias ll="ls -lahG"
alias reload="exec $SHELL -l"
alias profile="vim ~/.profile"
alias p="echo ''; cd ~/code; ls -c1; echo '';"
alias desktop="cd ~/Desktop"
alias server="python -m SimpleHTTPServer"
alias wifi="wifi-password"
alias bitly="bitly-client"
alias hf="history | fzf"

# git
alias co="git checkout"
alias s="echo ''; git status -sb; echo ''"
alias c="git commit"
alias cm="fact; git commit -am"
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
alias opr="hub pr show"

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
__git_complete co _git_checkout
__git_complete push _git_push

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# postgres
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost




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
