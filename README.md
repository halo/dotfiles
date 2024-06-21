### Installation

Get the repository:

```bash
git clone https://github.com/halo/dotfiles.git ~/.dotfiles
```

Add the executables to your $PATH:

```bash
# Add this line to ~/.zshrc
export PATH="~/.dotfiles/bin:$PATH"
```

### Usage

Run `dotfiles` in your Terminal to put all configuration files in place.

Run `macos` to configure the operating system defaults.

### Caveats

```bash
export PATH=/opt/homebrew/bin:$PATH
rbenv install 3.3.0
eval "$(rbenv init - zsh)"
rbenv global 3.3.0
rbenv shell 3.3.0
~/.dotfiles/bin/dotfiles
```
