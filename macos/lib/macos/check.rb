module MacOS
  class Check
    def initialize(good:)
      @good = good
    end

    # Nothing to do
    def pass!
      spinner.update title: Pastel.new.dim(good)
      spinner.success
    end

    # Not applicable
    def skip!(message = 'not applicable')
      spinner.update title: Pastel.new.dim("#{good} (#{message})")
      spinner.success
    end

    # Changes have been performed.
    def fixed!
      spinner.update title: Pastel.new.green(good)
      spinner.success
    end

    def conflict!(message)
      spinner.update title: Pastel.new.yellow("#{good} (#{message})")
      spinner.stop
    end

    # Cannot be performed while System Preferences is open.
    def system_preferences_conflict!
      spinner.update title: Pastel.new.yellow("#{good} (please quit System Preferences first)")
      spinner.stop
    end

    # Cannot be performed while Chrome is open.
    def chrome_conflict!
      spinner.update title: Pastel.new.yellow("#{good} (please quit Chrome first)")
      spinner.stop
    end

    # Cannot be performed if sudo is not allowed.
    def needs_sudo!
      spinner.update title: Pastel.new.yellow("#{good} (please add the --sudo flag)")
      spinner.stop
    end

    private

    attr_reader :good

    def spinner
      @spinner ||= spinner!
    end

    def spinner!
      result = TTY::Spinner.new ' :spinner  :title', success_mark: success_mark, error_mark: error_mark, frames: frames
      result.update title: good
      result.auto_spin
      result
    end

    def success_mark
      Pastel.new.green '✔'
    end

    def error_mark
      Pastel.new.red '✖'
    end

    def frames
      TTY::Formats::FORMATS.dig(:dots, :frames).unshift ' '
    end
  end
end
