module MacOS
  module Customize
    class Keyboard
      # See https://apple.stackexchange.com/a/55729
      #  @ = command
      #  ^ = control
      #  ~ = option
      #  $ = shift
      #  \0 = NULL
      def call
        # Deactivate these undoable shortcuts
        set_shortcut caption: 'Hide Finder', keycode: '\0'
        set_shortcut caption: 'Hide Google Chrome', keycode: '\0'
        set_shortcut caption: 'Hide Mail', keycode: '\0'
        set_shortcut caption: 'Hide Safari', keycode: '\0'
        set_shortcut caption: 'Hide Visual Studio Code', keycode: '\0'

        set_shortcut caption: 'Hide Others', keycode: '\0'
        set_shortcut caption: 'Enter Full Screen', keycode: '\0'
        set_shortcut caption: 'Minimize', keycode: '\0'

        # Homogenious tabbing in all apps
        set_shortcut caption: 'Next Tab', keycode: "~@→"
        set_shortcut caption: 'Show Next Tab', keycode: "~@→"
        set_shortcut caption: 'Select Next Tab', keycode: "~@→"
        set_shortcut caption: 'Previous Tab', keycode: "~@←"
        set_shortcut caption: 'Show Previous Tab', keycode: "~@←"
        set_shortcut caption: 'Select Previous Tab', keycode: "~@←"

        # Export in Quicktime and Pages
        # set_shortcut caption: 'Export To', keycode: "$@e"
        # set_shortcut caption: 'Export As', keycode: "$@e"

        # Making Safari behave like Chrome in this respect
        # set_shortcut app: 'com.apple.Safari', caption: 'Clear History...', keycode: "$@⌫" # Does not work on Catalina
        set_shortcut caption: 'Clear History...', keycode: "$@⌫"

        # I use this feature very often but it has no shortcut
        set_shortcut app: 'com.apple.Preview', caption: 'Adjust Size...', keycode: "$@r"

        # I accidentally press CMD + Enter and I don't want it to go to fullscreen..
        set_shortcut app: 'com.googlecode.iterm2', caption: 'Toggle Full Screen', keycode: '\0'

        system 'killall Finder' if @restart_finder && Runtime.apply_mode?
      end

      private

      def set_shortcut(app: :global, caption:, keycode:)
        readable_keycode = keycode == '\0' ? :deactivated : keycode
        check = Check.new good: %("#{caption}" shortcut is #{readable_keycode})

        setting = OS::Defaults::Dict.new(domain: app, key: 'NSUserKeyEquivalents')

        if setting.match(expected_string: expected_output(caption: caption, keycode: keycode))
          check.pass!
        else
          setting.add! key: caption, value: keycode
          check.fixed!
          @restart_finder = true
        end
      end

      def expected_output(caption:, keycode:)
        return %(#{escape_caption(caption)} = "") if keycode == '\0'

        keycodes = keycode.split('').map do |code|
          next code if %w[@ ^ ~ $ r].include?(code)
          "\\\\U#{code.ord.to_s(16)}"
        end

        %(#{escape_caption(caption)} = "#{keycodes.join}")
      end

      def escape_caption(caption)
        return caption unless caption.include?(' ')
        %("#{caption}")
      end
    end
  end
end
