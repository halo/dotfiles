export RBENV_ROOT="<%= @home_path %>/.biosphere/spheres/bukowskis/rbenv"
export PATH="${RBENV_ROOT}/bin:$PATH"
[[ -d "${RBENV_ROOT}/bin" ]] && eval "$(rbenv init -)"

### CHEF MANAGED START ###

# Adding the "bio" executable to your path.
export PATH="/Users/zoo/.biosphere/core/bin:$PATH"

# Loading Biosphere's bash_profile for easier de-/activation of spheres.
[[ -s /Users/zoo/.biosphere/active/bash_profile ]] && source /Users/zoo/.biosphere/active/bash_profile

### CHEF MANAGED STOP ###

# Override git-config "core.editor" to enforce vim when using SSH
if test -n "$SSH_CONNECTION"; then
  export GIT_EDITOR='vim'
fi

# Git prompt
[[ -s "$HOME/.git-ps1" ]] && export PS1='$(~/.git-ps1 "[\u@\h \w]\$ ")'

# File editing
alias hosts='sudo mate /etc/hosts'
alias sshconf='mate ~/.ssh/config'
alias known='mate ~/.ssh/known_hosts'
alias keys="open ~/.ssh"

# Directories
alias p="cd ~/Projects"
alias pc="cd ~/Projects/chef-repo"
alias pa="cd ~/Projects/auktion"

# TextMate
alias o="open ."
alias m="mate"

# Shell
alias reload='source ~/.bash_profile && echo "sourced ~/.bash_profile"'
alias ls='ls -G'
alias la='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Rails
alias sc='script/console'
alias tdev='tail -n 90 -f log/development.log'
alias rst="touch tmp/restart.txt && echo touched tmp/restart.txt"

# Other:
alias online="ping -c 1 www.sunet.se &> /dev/null && echo 'Online :)' || echo 'Offline :('"

# Git
alias gl="git pull --rebase"
alias gs="git status"
alias gw="git show"
alias gd="git diff"  # What's changed but not yet added?
alias gdm="git diff | mate"
alias gdc="git diff --cached"  # What's added but not yet committed?
alias gdcm="git diff --cached | mate"
alias ga='git add'
alias gc="git commit -v"
alias gam="git commit --amend"
alias gco="git checkout"
alias gg='git grep'
alias go="git checkout"
alias gb="git branch"
alias gp='git push'
alias gpp='git pull --rebase && git push'
alias gppm='git pull origin master --rebase && git push origin master'
alias gcp="git cherry-pick"
alias gm='git merge'
alias gr='git remote show origin'
alias stats='git shortlog -s -n'

function guser {
  if [ -z "$1" ]
  then
  echo "Current git configuration:"
    git config --get user.name
    git config --get user.email
  else
    echo "New git configuration:"
    git config user.name $1
    git config user.email $2
    git config --get user.name
    git config --get user.email
  fi
}

# Functions
function diffx {
  `/Developer/Applications/Utilities/FileMerge.app/Contents/MacOS/FileMerge -left $1 -right $2`
}
