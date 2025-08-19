module MacOS
  module OS
    class Scutil
      # def self.match(key:, expected_string:)
      #   get(key: key).include? expected_string
      # end

      def self.get(key:)
        Command.new('/usr/sbin/scutil', '--get', key).out
      end

      def self.set(key:, value:)
        Command::Sudo.new('/usr/sbin/scutil', '--set', key, value).out
      end
    end
  end
end
