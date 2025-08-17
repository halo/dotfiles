module Dotfiles
  module Apps
    class Iterm2
      def call
        Connect.call caption: 'iTerm2 Profile',
                     symlink_destination: local.join('halo.json'),
                     symlink_source: remote.join('DynamicProfiles/halo.json')

        puts Pastel.new.bold 'iTerm2 Preferences'
        puts Pastel.new.dim "  Pointing to `#{local}`"
        system "/usr/bin/defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string '#{local}'"
        system '/usr/bin/defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true'
      end

      private

      def local
        Dotfiles.apps.join 'iterm2'
      end

      def remote
        Pathname.new('~')
                .expand_path
                .join('Library', 'Application Support', 'iTerm2')
      end
    end
  end
end
