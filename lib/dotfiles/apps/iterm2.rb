module Dotfiles
  module Apps
    class Iterm2
      def call
        puts Pastel.new.bold "iTerm2 Preferences"
        puts Pastel.new.dim "  Pointing to `#{local}`"
        system "/usr/bin/defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string '#{local}'"
        system '/usr/bin/defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true'
      end

      private

      def local
        Dotfiles.apps.join 'iterm2'
      end
    end
  end
end

