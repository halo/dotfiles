module MacOS
  module Customize
    class Keyboard
      def call
        disable caption: 'Hide Others'
        disable caption: 'Enter Full Screen'

        system 'killall Finder' if @restart_finder && Runtime.apply_mode?
      end

      private

      def disable(caption:)
        check = Check.new good: %("#{caption}" shortcut is deactivated)
        setting = OS::Defaults::Dict.new(key: 'NSUserKeyEquivalents')

        expected_escaped_output = %("#{caption}" = "#{suffix_separator.gsub('\\', '\\\\\\')}")

        if setting.match(expected_string: expected_escaped_output)
          check.pass!
        else
          setting.add! key: caption, value: suffix_separator
          check.fixed!
          @restart_finder = true
        end
      end

      # Two additional backslashes for ruby string escaping.
      def suffix_separator
        '@~^$\\\\U00b4'
      end
    end
  end
end
