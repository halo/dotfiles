# The shell runs `/usr/libexec/path_helper` to setup $PATH
# It begins with these global system entries: `cat /etc/paths` (could be overwritten by OS updates)
# After that it loads every personal file in `cat /etc/paths.d/*` (never overwritten by OS updates)

alias paths="echo; echo \$PATH | tr ':' '\n'; echo"

# Shell
source $HOME/.dotfiles/shell/autocompletion
source $HOME/.dotfiles/shell/shortcuts
source $HOME/.dotfiles/shell/general
source $HOME/.dotfiles/shell/git
source $HOME/.dotfiles/shell/history
source $HOME/.dotfiles/shell/homebrew
source $HOME/.dotfiles/shell/hooks
source $HOME/.dotfiles/shell/media
source $HOME/.dotfiles/shell/prompt
source $HOME/.dotfiles/shell/rails
source $HOME/.dotfiles/shell/mise
source $HOME/.dotfiles/shell/rspec
source $HOME/.dotfiles/shell/ruby
source $HOME/.dotfiles/shell/shell

# User Paths
# export PATH="$PATH:$HOME/.local/share/mise/shims"
export PATH="$PATH:$HOME/.dotfiles/bin"
export PATH="$PATH:$HOME/.dotfiles/git/bin"
export PATH="$PATH:$HOME/.dotfiles/macos/bin"
export PATH="$PATH:$HOME/code/filing/filing/bin"
export PATH="$PATH:$HOME/.go/bin"

# Local bin directory takes highest precedence
# Being careful as to when a bin directory is around I don't know the contents of :)
export PATH="bin:$PATH"

[ -s ~/.zshrc.local ] && source ~/.zshrc.local

eval "$(starship init zsh)"

