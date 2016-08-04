# dependencies
source ~/.git-completion.sh
source ~/.git-prompt.sh
eval "$(hub alias -s)"
eval "$(thefuck --alias)"
eval "$(rbenv init -)"

# prompt
PS1='⚡️ \[\e[0;31m\]${PWD##*/}\[\e[m\]$(__git_ps1 "@\[\e[0;33m\]%s\[\e[m\]") ~ '

# general
alias no="noti"
alias ls="ls -c1"
alias la="ls -a"
alias ll="ls -lahG"
alias reload="exec $SHELL -l"
alias profile="vim ~/.profile"
alias p="echo ''; cd ~/local-dev; ls -c1; echo '';"
alias desktop="cd ~/Desktop"
alias server="python -m SimpleHTTPServer"
alias t="echo ''; cd ~/launchpad/carlsbad/cache/default/main/GettyPublic/WORKAREA/wkentdaggett; ls -c1; echo '';"
alias wifi="wifi-password"
alias bitly="bitly-client"
alias done="echo ''; lpass logout; mac sleep;"

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
alias branch="git branch"
alias amend="git commit --amend -m"

# copies password to clipboard
function cpass() {
  lpass show -p "$@" | pbcopy && echo '✓ copied'
}

# creates a new directory h/t http://bit.ly/2a9SPBi
function mk() {
  mkdir -p "$@" && cd "$@"
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
