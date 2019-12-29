module MacOS
  module Customize
    class ScreenSaver
      def call
        deactivate
        saver
        message
      end

      private

      def deactivate
        check = Check.new good: 'Screen saver does activate itself'
        setting = OS::Defaults::Int.new(current_host: true, domain: 'com.apple.screensaver', key: 'idleTime')

        if setting.zero?
          check.pass!
        else
          return check.system_preferences_conflict! if OS::SystemPreferences.running?
          setting.set! 0
          check.fixed!
        end
      end

      def saver
        check = Check.new good: 'Screen saver is the jumping apple'
        setting = OS::Defaults::Dict.new(current_host: true, domain: 'com.apple.screensaver', key: 'moduleDict')

        if setting.match(expected_string: 'moduleName = "Computer Name"')
          check.pass!
        else
          return check.system_preferences_conflict! if OS::SystemPreferences.running?
          setting.set! *dictionary
          check.fixed!
        end
      end

      def dictionary
        ['moduleName', '"Computer Name"', 'path', '"/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver"', 'type', 0]
      end

      def message
        check = Check.new good: 'Screen saver message is blank'
        setting = OS::Defaults::String.new(current_host: true, domain: 'com.apple.screensaver.Basic', key: 'MESSAGE')

        if setting.match(expected_string: '\240')
          check.pass!
        else
          return check.system_preferences_conflict! if OS::SystemPreferences.running?
          setting.set! ' '
          check.fixed!
        end
      end
    end
  end
end
