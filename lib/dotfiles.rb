require 'pastel'
require 'pathname'

require 'dotfiles/connect'
require 'dotfiles/files'

require 'dotfiles/apps/alfred'
require 'dotfiles/apps/iterm2'
require 'dotfiles/apps/stepmania'
require 'dotfiles/apps/vscode'

module Dotfiles
  def self.call
    puts
    Files.new.call
    Apps::Alfred.new.call
    Apps::Stepmania.new.call
    Apps::Iterm2.new.call
    Apps::Vscode.new.call
    puts
  end

  def self.dotfiles
    Pathname.new(__dir__).parent.join('dotfiles')
  end

  def self.apps
    Pathname.new(__dir__).parent.join('apps')
  end

  def self.dry?
    ARGV.include?('--dry')
  end

  def self.force?
    ARGV.include?('--force')
  end
end
