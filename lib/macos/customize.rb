require 'macos/customize/energy'
require 'macos/customize/screen_saver'
require 'macos/customize/termination'

module MacOS
  module Customize
    def self.call
      Energy.new.call
      Termination.new.call
      ScreenSaver.new.call
    end
  end
end
