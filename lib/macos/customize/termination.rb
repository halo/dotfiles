module MacOS
  module Customize
    class Termination
      def call
        restart_after_freeze
        disable_automatic_termination
      end

      private

      def restart_after_freeze
        check = Check.new good: 'Automatically restart when the system freezes'

        if OS::Systemsetup.match(key: 'restartfreeze', expected_string: 'Restart After Freeze: On')
          check.pass!
        else
          OS::Systemsetup.set(key: 'restartfreeze', value: 'on')
          check.fixed!
        end
      end

      def disable_automatic_termination
        check = Check.new good: 'Prevent inactive apps from terminating automatically'
        setting = OS::Defaults::Bool.new(key: 'NSDisableAutomaticTermination')

        if setting.on?
          check.pass!
        else
          setting.on!
          check.fixed!
        end
      end
    end
  end
end
