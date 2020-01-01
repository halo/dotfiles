require_relative '../vendor/install'

require 'pastel'
require 'pathname'

require 'dotfiles/connect'
require 'dotfiles/files'

require 'dotfiles/apps/alfred'
require 'dotfiles/apps/stepmania'
require 'dotfiles/apps/vscode'

module Dotfiles
  def self.call
    puts
    Files.new.call
    Apps::Alfred.new.call
    Apps::Stepmania.new.call
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
