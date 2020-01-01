module Dotfiles
  module Apps
    class Alfred
      def call
        Connect.call caption: 'Alfred Appearance',
                     file: local.join('preferences/appearance/options/prefs.plist'),
                     link: remote.join('preferences/appearance/options/prefs.plist')

        Connect.call caption: 'Alfred Features System',
                     file: local.join('preferences/features/system/prefs.plist'),
                     link: remote.join('preferences/features/system/prefs.plist')
      end

      private

      def local
        Dotfiles.apps.join 'alfred'
      end

      def remote
        Pathname.new('~')
                .expand_path
                .join('Library', 'Application Support', 'Alfred', 'Alfred.alfredpreferences')
      end
    end
  end
end
