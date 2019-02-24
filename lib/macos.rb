require 'founder'
Founder.install logger: ::Logger.new('/dev/null')

require 'tty-prompt'
require 'tty-command'
require 'tty-spinner'
require 'tty-platform'

require 'macos/runtime'
require 'macos/command'
require 'macos/spinner'

require 'macos/os/pmset'
require 'macos/os/system_preferences'

require 'macos/customize'
require 'macos/harden'

module Macos
  def self.call
    puts
    puts Pastel.new.bold ' Hardening'
    Macos::Harden.call
    puts
    puts Pastel.new.bold ' Customizing'
    Macos::Customize.call
    puts
  end

  def self.sudo?

  end
end
