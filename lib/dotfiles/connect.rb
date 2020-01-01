module Dotfiles
  class Connect
    def self.call(caption:, file:, link:)
      new(caption: caption, file: file, link: link).call
    end

    attr_reader :caption, :file, :link

    def initialize(caption:, file:, link:)
      @caption = caption
      @file = file
      @link = link
    end

    def call
      say caption

      if already_connected?
        whisper "  Symlink `#{unexpand(link)}` already points to file `#{unexpand(file)}`"
        return
      end

      if link.symlink?
        whisper "  Deleting existing symlink `#{unexpand(link)}` which points to `#{unexpand(link.readlink)}`..."
        delete
      end

      if link.directory? && link.empty?
        whisper "  Deleting empty directory `#{unexpand(link)}`..."
        delete
      end

      if link.file? && link.empty?
        whisper "  Deleting empty file `#{unexpand(link)}`..."
        delete
      end

      if link.file?
        if Dotfiles.force?
          warn "  Deleting existing file `#{unexpand(link)}`..."
          delete
        else
          scream "  Not touching existing file `#{unexpand(link)}`. Use --force to delete it."
          return
        end
      end

      if link.directory?
        scream "  Not touching existing directory `#{unexpand(link)}`. Please delete it manually."
        return
      end

      directory = link.parent
      unless directory.exist?
        whisper "  Creating necessary directory `#{unexpand(directory)}`..."
        directory.mkpath unless Dotfiles.dry?
      end

      success "  Pointing symlink `#{unexpand(link)}` to file `#{unexpand(file)}`..."
      link.make_symlink(file) unless Dotfiles.dry?


    end

    private

    def already_connected?
      link.symlink? && link.exist? && link.realpath == file
    end

    def delete
      link.delete unless Dotfiles.dry?
    end

    def say(message)
      puts Pastel.new.bold(message)
    end

    def whisper(message)
      puts Pastel.new.dim(message)
    end

    def warn(message)
      puts Pastel.new.yellow(message)
    end

    def success(message)
      puts Pastel.new.green(message)
    end

    def scream(message)
      puts Pastel.new.red(message)
    end

    def unexpand(path)
      home = Pathname.new('~').expand_path
      return path if path.relative_path_from(home).to_s.start_with?('..')
      "~/#{path.relative_path_from(home)}"
    end
  end
end
