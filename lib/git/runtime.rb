module Git
  module Runtime
    def self.debug_mode?
      command_line_arguments.delete('--debug') || ENV['DEBUG']
    end

    def self.dry_mode?
      command_line_arguments.delete('--dry')
    end

    def self.help_mode?
      command_line_arguments.delete '--help'
    end

    def self.version_mode?
      command_line_arguments.delete('--version') || command_line_arguments.delete('-v')
    end

    def self.arguments
      command_line_arguments - %w[--debug --help --version -v]
    end

    def self.command_line_arguments
      ARGV.dup
    end
    private_class_method :command_line_arguments
  end
end
