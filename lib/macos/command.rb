module Macos
  class Command
    def initialize(args, sudo: false)
      @args = args
      @sudo = sudo
    end

    def out
      command.out
    end

    def run
      command
    end

    private

    attr_reader :args, :sudo

    def command
      @command ||= command!
    end

    def command!
      result = TTY::Command.new(printer: :null)

      if sudo
        result.run('/usr/bin/sudo', *args)
      else
        result.run(*args)
      end
    end
  end
end
