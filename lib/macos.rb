require 'founder'
Founder.install logger: ::Logger.new('/dev/null')

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
require 'macos/os/global_daemon'
require 'macos/os/pmset'
require 'macos/os/system_preferences'
require 'macos/os/systemsetup'

require 'macos/customize/energy'
require 'macos/customize/chromex'
require 'macos/customize/file_vault'
require 'macos/customize/screen_saver'
require 'macos/customize/termination'

module MacOS
  def self.call
    puts
    # MacOS::Customize::FileVault.new.call
    MacOS::Customize::Energy.new.call
    MacOS::Customize::Termination.new.call
    MacOS::Customize::ScreenSaver.new.call
    # MacOS::Customize::Chromex.new.call
    puts
  end

  def self.sudo?

  end
end
