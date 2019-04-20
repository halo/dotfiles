module MacOS
  module OS
    class GlobalDaemon
      def initialize(label:, program_arguments:, run_at_load:, start_interval: nil, standard_out_path: nil, standard_error_path: nil, watch_paths: nil, network_state: nil)
        @label = label
        @program_arguments = program_arguments
        @run_at_load = run_at_load
        @start_interval = start_interval
        @network_state = network_state
        @standard_out_path = standard_out_path
        @standard_error_path = standard_error_path
        @watch_paths = watch_paths
      end

      def install!
        temporary_plist.write plist_content
        temporary_plist.close
        Command::Sudo.new('/bin/cp', temporary_plist.path, plist_path).run
        temporary_plist.unlink
        Command::Sudo.new('/bin/chmod', '644', plist_path).run
        @refresh = true
      end

      def launch!
        Command::Sudo.new('/bin/launchctl', 'bootout', 'system', plist_path).run(allow_failure: true)
        Command::Sudo.new('/bin/launchctl', 'bootstrap', 'system', plist_path).run
      end

      def exists?
        plist_path.readable? && plist_path.read == plist_content
      end

      def loaded?
        # info = Command.new('/bin/launchctl', 'print', "system/#{label}").out(allow_failure: true)
        # This is a poor mans version of checking whether the plist cached inside launchctl is accurate.
        # program_arguments.all? { |argument| info.include?(argument) }
        false
      end

      private

      attr_reader :label, :program_arguments, :run_at_load, :start_interval,
                  :standard_out_path, :standard_error_path, :watch_paths, :network_state

      def temporary_plist
        @temporary_plist ||= Tempfile.new(plist_path.basename.to_s)
      end

      def plist_path
        Pathname.new('/Library/LaunchDaemons').join "#{label}.plist"
      end

      def plist_content
        properties.to_plist
      end

      def properties
        keys = %w[
          label program_arguments run_at_load start_interval
          standard_out_path standard_error_path watch_paths network_state
        ]
        result = {}
        keys.each do |key|
          next if send(key).nil?
          result[key.to_s.split('_').map(&:capitalize).join] = send(key)
        end
        result
      end
    end
  end
end
