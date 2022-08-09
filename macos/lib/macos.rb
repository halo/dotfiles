require 'json'
require 'pathname'

require 'plist'
require 'tty-prompt'
require 'tty-command'
require 'tty-spinner'
require 'tty-platform'

require 'macos/runtime'
require 'macos/command'
require 'macos/check'

require 'macos/os/defaults'
require 'macos/os/pmset'
require 'macos/os/scutil'
require 'macos/os/system_preferences'
require 'macos/os/systemsetup'

require 'macos/customize/energy'
require 'macos/customize/chromex'
require 'macos/customize/file_vault'
require 'macos/customize/finder_favorites'
require 'macos/customize/sharing'
require 'macos/customize/keyboard'
require 'macos/customize/trackpad'
require 'macos/customize/screen_saver'

module MacOS
  def self.call
    puts
    # MacOS::Customize::FileVault.new.call
    MacOS::Customize::Energy.new.call
    MacOS::Customize::Sharing.new.call
    MacOS::Customize::Keyboard.new.call
    MacOS::Customize::Trackpad.new.call
    #MacOS::Customize::FinderFavorites.new.call
    #MacOS::Customize::ScreenSaver.new.call
    # MacOS::Customize::Chromex.new.call
    puts
  end
end
