module Macos
  module Harden
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
        TTY::Command.new(printer: :null).run '/usr/bin/fdesetup', 'status'
      end

      def spinner
        @spinner ||= Macos::Spinner.new('Checking if FileVault is enabled...')
      end
    end
  end
end
