module Dotfiles
  module Apps
    class Vscode
      def call
        Connect.call caption: 'Visual Studio Code Settings',
                     file: local.join('settings.json'),
                     link: remote.join('settings.json')

        Connect.call caption: 'Visual Studio Code Key Bindings',
                     file: local.join('keybindings.json'),
                     link: remote.join('keybindings.json')

        Connect.call caption: 'Visual Studio Code Snippets',
                     file: local.join('snippets'),
                     link: remote.join('snippets')
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
