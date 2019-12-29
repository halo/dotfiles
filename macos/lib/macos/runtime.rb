# frozen_string_literal: true

module MacOS
  module Runtime
    def self.privileged?
      Process.uid == 0
    end

    # Usually set via CLI argument.
    # But can be set via ENV for more output when running tests.
    def self.debug_mode?
      command_line_arguments.delete('--debug') || ENV['DEBUG']
    end

    def self.sudo_mode?
      command_line_arguments.delete '--sudo'
    end

    def self.apply_mode?
      command_line_arguments.delete '--apply'
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
  end
end
