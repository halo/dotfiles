module Dotfiles
  module Apps
    class Vscode
      def call
        Connect.call caption: 'Visual Studio Code Settings',
                     symlink_destination: local.join('settings.json'),
                     symlink_source: remote.join('settings.json')

        Connect.call caption: 'Visual Studio Code Key Bindings',
                     symlink_destination: local.join('keybindings.json'),
                     symlink_source: remote.join('keybindings.json')

        Connect.call caption: 'Visual Studio Code Snippets',
                     symlink_destination: local.join('snippets'),
                     symlink_source: remote.join('snippets')
      end

      private

      def local
        Dotfiles.apps.join 'vscode'
      end

      def remote
        Pathname.new('~').expand_path.join('Library', 'Application Support', 'Code', 'User')
      end
    end
  end
end
