module MacOS
  module OS
    class SystemPreferences
      def self.running?
        processes = TTY::Command.new(printer: :null).run('/bin/ps', 'ax').out
        processes.include? '/Applications/System Preferences.app'
      end
    end
  end
end
