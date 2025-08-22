#!/usr/bin/env -S mise exec ruby -- ruby
# frozen_string_literal: true

# @raycast.schemaVersion 1
# @raycast.title Compile Dotfiles to Desktop
# @raycast.mode silent

# Optional parameters:
# @raycast.icon raycast.png
# @raycast.packageName Raycast

require 'pathname'
require 'tty-command'

root = Pathname.new(__dir__).join('../settings')

json_path = root.join('script_directories.json')

# Fetch the pre-generated header that Raycast has in its files for some reason.
header = root.join('header.bin').binread

# Zip the settings
zip = TTY::Command.new(printer: :null, binmode: true).run!('gzip', '-c', json_path.to_s).out

# Put it both together
combined_content = header + zip

# Encrypt it to a file on the Desktop
rayconfig_path = Pathname.new('~/Desktop/script_directories.rayconfig').expand_path
TTY::Command.new(printer: :null, binmode: true).run!('openssl', 'enc',
                                                     '-e', '-aes-256-cbc',
                                                     '-nosalt',
                                                     '-k', '12345678',
                                                     '-out', rayconfig_path.to_s,
                                                     input: combined_content)

system('open ~/Desktop/')
