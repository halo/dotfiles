require 'macos/customize/energy'

module Macos
  module Customize
    def self.call
      Macos::Customize::Energy.new.call
    end
  end
end
