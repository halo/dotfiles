module MacOS
  module Customize
    class FileVault
      def call
        if enabled?
          spinner.success 'FileVault is enabled'
        else
          spinner.error 'FileVault is inactive'
        end
      end

      private

      def enabled?
        command.out.include? 'FileVault is On'
      end

      def command
        MacOS::Command.new ['/usr/bin/fdesetup', 'status']
      end

      def spinner
        @spinner ||= Check.new(good: 'Checking if FileVault is enabled...')
      end
    end
  end
end
