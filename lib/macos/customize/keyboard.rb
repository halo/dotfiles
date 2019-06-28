module MacOS
  module Customize
    class Keyboard
      #  @ = command
      #  ^ = control
      #  ~ = option
      #  $ = shift
      #  \0 = NULL
      def call
        set_shortcut caption: 'Hide Others', keycode: '\0'
        set_shortcut caption: 'Enter Full Screen', keycode: '\0'
        set_shortcut caption: 'Minimize', keycode: '\0'

        set_shortcut caption: 'Next Tab', keycode: "~@→"
        set_shortcut caption: 'Show Next Tab', keycode: "~@→"
        set_shortcut caption: 'Select Next Tab', keycode: "~@→"

        set_shortcut caption: 'Previous Tab', keycode: "~@←"
        set_shortcut caption: 'Show Previous Tab', keycode: "~@←"
        set_shortcut caption: 'Select Previous Tab', keycode: "~@←"

        system 'killall Finder' if @restart_finder && Runtime.apply_mode?
      end

      private

      def set_shortcut(caption:, keycode:)
        readable_keycode = keycode == '\0' ? :deactivated : keycode
        check = Check.new good: %("#{caption}" shortcut is #{readable_keycode})

        setting = OS::Defaults::Dict.new(key: 'NSUserKeyEquivalents')
        if setting.match(expected_string: expected_output(caption: caption, keycode: keycode))
          check.pass!
        else
          setting.add! key: caption, value: keycode
          check.fixed!
          @restart_finder = true
        end
      end

      def expected_output(caption:, keycode:)
        return '' if keycode == '\0'
        keycodes = keycode.split('')
        keycodes[-1] = "\\\\U#{keycodes.last.ord.to_s(16)}"
        %("#{caption}" = "#{keycodes.join}")
      end
    end
  end
end
