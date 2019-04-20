module MacOS
  module OS
    class Defaults
      class Base
        def initialize(domain: :global, key:, current_host: false)
          @domain = domain
          @key = key
          @current_host = current_host
        end

        def match(expected_string:)
          get.include? expected_string
        end

        private

        attr_reader :key, :datatype, :current_host

        def domain
          @domain == :global ? '-g' : @domain
        end

        def options
          return %w[-currentHost] if current_host
          []
        end
      end

      class Bool < Base
        def on?
          Command.new('/usr/bin/defaults', *options, 'read', domain, key).out(allow_failure: true).include? '1'
        end

        def on!
          Command.new('/usr/bin/defaults', *options, 'write', domain, key, '-bool', 'true').run
        end
      end

      class String < Base
        def set!(string)
          Command.new('/usr/bin/defaults', *options, 'write', domain, key, '-string', string).run
        end

        def get
          Command.new('/usr/bin/defaults', *options, 'read', domain, key).out(allow_failure: true)
        end
      end

      class Int < Base
        def zero?
          get == "0\n"
        end

        def get
          Command.new('/usr/bin/defaults', *options, 'read', domain, key).out(allow_failure: true)
        end

        def set!(value)
          Command.new('/usr/bin/defaults', *options, 'write', domain, key, '-int', value).run
        end
      end

      class Dict < Base
        def get
          Command.new('/usr/bin/defaults', *options, 'read', domain, key).out(allow_failure: true)
        end

        def set!(*values)
          Command.new('/usr/bin/defaults', *options, 'write', domain, key, '-dict', *values).run
        end
      end
    end
  end
end
