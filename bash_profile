export RBENV_ROOT="<%= @home_path %>/.biosphere/spheres/bukowskis/rbenv"
export PATH="${RBENV_ROOT}/bin:$PATH"
[[ -d "${RBENV_ROOT}/bin" ]] && eval "$(rbenv init -)"     # rbenv mode

### CHEF MANAGED START ###

# Adding the "bio" executable to your path.
export PATH="/Users/zoo/.biosphere/core/bin:$PATH"

# Loading Biosphere's bash_profile for easier de-/activation of spheres.
[[ -s /Users/zoo/.biosphere/active/bash_profile ]] && source /Users/zoo/.biosphere/active/bash_profile

### CHEF MANAGED STOP ###

# Override git-config "core.editor" to enforce it over SSH
if test -n "$SSH_CONNECTION"; then
  export GIT_EDITOR='vi'
fi

# Git fancy
[[ -s "$HOME/.git-ps1" ]] && export PS1='$(~/.git-ps1 "[\u@\h \w]\$ ")'
[[ -s "$HOME/.git-completion.bash" ]] && source "$HOME/.git-completion.bash"

# The rest is just aliases

# Dirs
alias p="cd ~/Projects"
alias a="cd ~/Projects/auktion"
alias pa="cd ~/Projects/auktion"
alias tc="cd ~/Projects/testbot_cloud"
alias t="cd ~/Projects/testbot"
alias o="open ."
alias m="mate"

# Management
alias dots="mate ~/.dotfiles"
alias reload='source ~/.bash_profile && echo "sourced ~/.bash_profile"'
alias redot='cd ~/.dotfiles && git pull && rake; cd -'

# Shell
alias c='clear'
alias la='ls -alh'
alias cdd='cd -'  # back to last directory
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Portable ls with colors
if ls --color -d . >/dev/null 2>&1; then
  alias ls='ls --color=auto'  # Linux
elif ls -G -d . >/dev/null 2>&1; then
  alias ls='ls -G'  # BSD/OS X
fi

# Ruby on Rails
alias ss='script/server'
alias ssp='DEV=true script/server -e production'
alias sc='script/console'
alias at="script/autospec -f -c"
alias cu='script/cucumber features -b -s -f progress'
alias cuf='rake features:focus'
alias rs='rake spec'
alias mig='rake db:migrate'
alias mpr='pa; mate app features config lib db/schema.rb db/migrate public spec script/cruise stories test todo.txt script/cron script/oneoff script/app Gemfile'
alias mpa='pa; mate .'
alias tdev='tail -n 90 -f log/development.log'
alias tdevp='tdev | egrep "*Parameters"'
alias tprod='tail -f log/production.log'
alias sp='script/spork'
alias spc='script/spork cucumber'
alias rsp='rake testbot:spec'
alias cup='rake testbot:features'
alias prep='rake db:test:prepare'
alias g='guard'
alias gf='FUNCTIONAL=true bundle exec guard start -n f'

# Git
alias gl="git pull --rebase"
alias gs="git status"
alias gst="git status"
alias gw="git show"
alias gd="git diff"  # What's changed but not yet added?
alias gdm="git diff | mate"
alias gdc="git diff --cached"  # What's added but not yet committed?
alias gdcm="git diff --cached | mate"
alias ga='git add'
alias gc="git commit -v -a"
alias gca="git commit -v -a"
alias gam="git commit --amend"
alias gco="git checkout"
alias go="git checkout"
alias gb="git checkout -b --color"
alias gba='git branch -a --color'
alias gp='git push'
alias gpp='git pull --rebase && git push'
alias gcp="git cherry-pick"
alias gm='git merge'
alias gr='git remote show origin'
alias gbt='git branch --track' # stubs origin/stubs
alias mim='mergeinmaster'
alias grb='git-remote-branch'
alias stats='git shortlog -s -n'

# Servers
alias rst="touch tmp/restart.txt && echo touched tmp/restart.txt"  # Passenger
alias res="touch tmp/restart.txt && echo touched tmp/restart.txt"  # Passenger

alias hosts='sudo mate /etc/hosts'
alias sshconf='mate ~/.ssh/config'
alias keys="open ~/.ssh"

# Other:
alias online="ping -c 1 www.sunet.se &> /dev/null && echo 'Online :)' || echo 'Offline :('"

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

function mkcd {
  mkdir -p "$1" && cd "$1"
}

function robots {
  osascript 2>/dev/null <<EOF
  tell application "System Events"
          tell process "Terminal" to keystroke "t" using command down
  end
  tell application "Terminal"
          activate
          do script with command "pa && clear && cup" in window 1
  end tell
  tell application "System Events"
          tell process "Terminal" to keystroke "t" using command down
  end
  tell application "Terminal"
          activate
          do script with command "pa && clear && rsp" in window 1
  end tell
EOF
}