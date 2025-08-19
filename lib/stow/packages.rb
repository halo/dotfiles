# frozen_string_literal: true

module Stow
  # Enumerate over files like "GNU stow".
  # For terminology see https://www.gnu.org/software/stow/manual/stow.html#Terminology
  class Packages
    def call
      package_directories.each do |package_directory|
        # E.g. `<this-git-repo>/dotfiles/bundler`
        puts Pastel.new.yellow.bold("[#{package_directory.basename}]")

        package_directory.glob('**/*', File::FNM_DOTMATCH).select(&:file?).map do |symlink_destination|
          # E.g. `~/.bundle/config`
          relative_symlink_source = symlink_destination.relative_path_from(package_directory)
          symlink_source = target_directory.join(relative_symlink_source)
          Connect.call(caption: symlink_source, symlink_source:, symlink_destination:)
        end
        puts
      end
    end

    private

    # Every directory inside the directory `<this-git-repo>/dotfiles`.
    #
    # So, if this repository was cloned to `~/.dotfiles` this would return:
    #   `~/.dotfiles/bundler`
    #   `~/.dotfiles/git`
    #
    def package_directories
      stow_directory.glob('*/')
    end

    # The source of our dotfiles.
    #
    def stow_directory
      Pathname.new(__dir__).parent.parent.join('dotfiles')
    end

    # Where the dotfiles must go on the disk.
    #
    def target_directory
      Pathname.new('~').expand_path
    end
  end
end
