module MacOS
  module Customize
    class Trackpad
      def call
        deactivate_haptic
      end

      private

      def deactivate_haptic
        check = Check.new good: 'Deactivate Haptic Trackpad...'
        setting = OS::Defaults::Bool.new(domain: domain, key: 'ForceSuppressed')
        return check.system_preferences_conflict! if OS::SystemPreferences.running?

        if setting.on?
          check.pass!
        else
          setting.on!
          check.fixed!
        end
      end

      def domain
        'com.apple.AppleMultitouchTrackpad'
      end
    end
  end
end
