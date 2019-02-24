module Macos
  class Spinner
    def initialize(title)
      @title = title
    end

    def success(message)
      spinner.update title: Pastel.new.green(message)
      spinner.success
    end

    def error(message)
      spinner.update title: Pastel.new.red(message)
      spinner.error
    end

    def warn(system_preferences: nil, needs_sudo: nil)
      message = 'not applicable'
      message = 'please quit System Preferences first' if system_preferences
      message = 'please add the --sudo flag' if needs_sudo
      spinner.update title: Pastel.new.yellow("#{title} (#{message})")
      spinner.stop
    end

    def skip
      spinner.update title: Pastel.new.dim('not applicable')
      spinner.stop
    end

    private

    attr_reader :title

    def spinner
      @spinner ||= spinner!
    end

    def spinner!
      result = TTY::Spinner.new ' :spinner  :title', success_mark: success_mark, error_mark: error_mark
      result.update title: title
      result.auto_spin
      result
    end

    def success_mark
      Pastel.new.green '✔'
    end

    def error_mark
      Pastel.new.red '✖'
    end
  end
end
