require 'founder'
Founder.install logger: ::Logger.new('/dev/null')

require 'tty-prompt'
require 'tty-command'
require 'tty-spinner'
require 'tty-platform'

require 'macos/runtime'
require 'macos/command'
require 'macos/check'

require 'macos/os/defaults'
require 'macos/os/pmset'
require 'macos/os/system_preferences'
require 'macos/os/systemsetup'

require 'macos/customize'
require 'macos/harden'

module MacOS
  def self.call
    puts
    MacOS::Harden.call
    MacOS::Customize.call
    puts
  end

  def self.sudo?

  end
end
