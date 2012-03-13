# My dotfiles

## Install

    git clone git://github.com/funkensturm/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && rake

This rake task will not replace existing files, but it will replace existing symlinks.

The dotfiles will be symlinked, e.g. `~/.bash_profile` symlinked to `~/.dotfiles/bash_profile`.

### <.replace>

If e.g. `~/.dotfiles/gitconfig` contains `<.replace github-token>` then

 * that bit will be replaced with the contents of `~/.github-token`
 * the resulting file will be written to `~/.dotfiles/gitconfig` directly, not symlinked

So if you want to make changes to that file, make them in `~/dotfiles/gitconfig` and then run `rake install` again.

Changes to symlinked files without `<.replace>` bits do not require a `rake install` on every change as they're symlinked.
