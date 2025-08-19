# frozen_string_literal: true

require 'pastel'
require 'pathname'

require 'stow/packages'
require 'stow/connect'

require 'dotfiles/apps/stepmania'

module Dotfiles
  def self.call
    puts
    Stow::Packages.new.call
    Apps::Stepmania.new.call
    puts
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
