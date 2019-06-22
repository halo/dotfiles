module MacOS
  module Customize
    class Sharing
      def call
        check = Check.new good: 'Computer Name is customized'
        return check.pass! unless computer_name_is_default?

        return check.needs_sudo! unless Runtime.sudo_mode?
        return check.system_preferences_conflict! if OS::SystemPreferences.running?
        OS::Scutil.set key: :ComputerName, value: sanitized_name
        check.fixed!
      end

      private

      def computer_name_is_default?
        current_name.include? suffix_separator
      end

      def sanitized_name
        current_name.split(suffix_separator).first
      end

      def current_name
        OS::Scutil.get(key: :ComputerName).chomp
      end

      def suffix_separator
        "’s Mac"
      end
    end
  end
end
