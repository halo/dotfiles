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
      end

      private

      def local
        Dotfiles.apps.join 'stepmania'
      end

      def remote
        Pathname.new('/').join('Applications', 'StepMania', 'Save')
      end
    end
  end
end
