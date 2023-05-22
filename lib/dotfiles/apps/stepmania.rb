module Dotfiles
  module Apps
    class Stepmania
      def call
        Connect.call caption: 'StepMania Keymaps',
                     file: local.join('Keymaps.ini'),
                     link: remote.join('Keymaps.ini'),
                     force: true,
                     copy: true

        Connect.call caption: 'StepMania Preferences',
                     file: local.join('Preferences.ini'),
                     link: remote.join('Preferences.ini'),
                     force: true,
                     copy: true
      rescue Errno::EACCES
        puts "Ignoring #{local} due to permissions."
      end

      private

      def local
        Dotfiles.apps.join 'stepmania'
      end

      def remote
        Pathname.new('/').join('Applications', 'Outfox', 'Save')
      end
    end
  end
end
