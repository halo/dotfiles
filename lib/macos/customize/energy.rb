module Macos
  module Customize
    class Energy
      def call
        settings.each do |(key, value, title)|
          %i[battery charger].each do |mode|
            apply key: key, value: value, title: title, mode: mode
          end
        end
      end

      private

      def settings
        [
          [:displaysleep, 0, 'display stays awake'],
        ]
      end

      def apply(key:, value:, title:, mode:)
        spinner = Macos::Spinner.new("Checking if #{title} in #{mode} mode...")

        case pmset.get mode: mode, key: key
        when nil        then spinner.skip
        when value.to_s then spinner.success("#{title.capitalize} in #{mode} mode")
        else
          return spinner.warn(system_preferences: true) if Macos::Os::SystemPreferences.running?
          return spinner.warn(needs_sudo: true) unless Macos::Runtime.sudo_mode?
          pmset.set mode: mode, key: key, value: value
        end
      end

      def pmset
        @pmset ||= Macos::Os::Pmset.new
      end
    end
  end
end
