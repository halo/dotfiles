require 'macos/harden/file_vault'

module Macos
  module Harden
    def self.call
      Macos::Harden::FileVault.new.call
    end
  end
end
