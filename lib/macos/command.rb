module MacOS
  class Command
    class Sudo < Command
      def command!(allow_failure: false)
        if allow_failure
          TTY::Command.new(printer: :null).run!('/usr/bin/sudo', *args)
        else
          TTY::Command.new(printer: :null).run('/usr/bin/sudo', *args)
        end
      end
    end

    def initialize(*args)
      @args = args
    end

    def out(allow_failure: false)
      command(allow_failure: allow_failure).out
    end

    def run(*args)
      command
    end

    def include?(string)
      out.include?(string)
    end

    private

    attr_reader :args, :sudo

    def command(allow_failure: false)
      @command ||= command!(allow_failure: allow_failure)
    end

    def command!(allow_failure: false)
      if allow_failure
        TTY::Command.new(printer: :null).run!(*args)
      else
        TTY::Command.new(printer: :null).run(*args)
      end
    end
  end
end
