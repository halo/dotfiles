module MacOS
  module OS
    class Systemsetup
      def self.match(key:, expected_string:)
        get(key: key).include? expected_string
      end

      def self.get(key:)
        Command::Sudo.new('/usr/sbin/systemsetup', "-get#{key}").out
      end

      def self.set(key:, value:)
        Command::Sudo.new('/usr/sbin/systemsetup', "-set#{key}", value).run
      end
    end
  end
end
