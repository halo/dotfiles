module MacOS
  module Customize
    class Energy
      def call
        settings.each do |(key, value, title)|
          %i[battery charger].each do |mode|
            apply key: key, value: value, title: title, mode: mode
          end
        end

        apply key: :lessbright, value: 1, mode: :battery, title: 'Slightly turn down display brightness'
        apply key: :womp, value: 0, mode: :charger, title: 'Do not wake up by network access'
      end

      private

      def settings
        [
          [:sleep, 0, 'Operating system stays awake'],
          [:displaysleep, 0, 'Display stays awake'],
          [:autopoweroff, 0, 'Avoid European Union energy saving'],
          [:standby, 1, 'Eventually hibernate when sleeping'],
          [:standbydelayhigh, 2 * 60 * 60, 'Enter hibernation after 2 hours'],
          [:standbydelaylow, 30, 'On low battery, enter hibernation after 30 seconds'],
          [:hibernatemode, 3, 'Hibernate using RAM and disk'],
          [:highstandbythreshold, 50, 'Assume battery is low under 50%'],
          [:acwake, 0, 'Do not wake up when power adapter is plugged in'],
          [:powernap, 0, 'Do not wake up to check for updates'],
        ]
      end

      def apply(key:, value:, title:, mode:)
        check = Check.new good: "#{title} on #{mode}"

        case pmset.get(mode: mode, key: key)
        when nil        then check.skip!
        when value.to_s then check.pass!
        else                 fix(check: check, mode: mode, key: key, value: value)
        end
      end

      def fix(check:, mode:, key:, value:)
        return check.system_preferences_conflict! if OS::SystemPreferences.running?
        return check.needs_sudo! unless Runtime.sudo_mode?

        pmset.set mode: mode, key: key, value: value
        check.fixed!
      end

      def pmset
        @pmset ||= OS::Pmset.new
      end
    end
  end
end
