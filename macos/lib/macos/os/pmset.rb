module MacOS
  module OS
    class Pmset
      def get(mode:, key:)
        case mode
        when :charger then charger(key)
        when :battery then battery(key)
        else               raise ArgumentError
        end
      end

      def set(mode:, key:, value:)
        modifier = mode == :charger ? '-c' : '-b'
        Command::Sudo.new('/usr/bin/pmset', modifier, key, value).run
      end

      private

      def settings
        @settings ||= Command.new('/usr/bin/pmset', '-g', 'custom').out
      end

      def battery(value)
        block('Battery Power:')[value.to_s]
      end

      def charger(value)
        block('AC Power:')[value.to_s]
      end

      def block(name)
        result = {}
        settings.split(name).last.split(':').first.split("\n").map do |pair|
          next if pair.empty?
          result[pair.split.first] = pair.split.last
        end
        result
      end
    end
  end
end
