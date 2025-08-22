#!/usr/bin/env -S mise exec ruby -- ruby
# frozen_string_literal: true

# @raycast.schemaVersion 1
# @raycast.title Decrypt Rayconfig from Desktop
# @raycast.mode silent

# Optional parameters:
# @raycast.icon raycast.png
# @raycast.packageName Raycast

require 'pathname'
require 'tty-command'

desktop_path = Pathname.new('~/Desktop').expand_path
encrypted_path = desktop_path.glob('*.rayconfig').first

unless encrypted_path
  warn 'Export a .rayconfig to Desktop first'
  exit 1
end

# Decrypt
decrypted_path = encrypted_path.sub_ext('.tmp')
TTY::Command.new(printer: :null, binmode: true)
            .run!('openssl', 'enc',
                  '-d', '-aes-256-cbc',
                  '-nosalt',
                  '-k', '12345678',
                  '-in', encrypted_path.to_s,
                  '-out', decrypted_path.to_s)

# Split away Header
header_data = TTY::Command.new(printer: :null, binmode: true)
                          .run!('head', '-c', '16', decrypted_path.to_s).out
header_path = desktop_path.join('header.bin')
header_path.binwrite(header_data)

# Split away Archive
zipped_data = TTY::Command.new(printer: :null, binmode: true)
                          .run!('tail', '-c', '+17', decrypted_path.to_s).out
zipped_path = encrypted_path.sub_ext('.json.gz')
zipped_path.binwrite(zipped_data)

# Extract Archive
TTY::Command.new(printer: :null, binmode: true)
            .run!('gunzip', zipped_path.to_s)

decrypted_path.delete

# puts ciphertext

# openssl enc -d -aes-256-cbc -nosalt -in "$INPUT_FILE" -k "$PASSWORD" 2>/dev/null
# | tail -c +17
# | gunzip > "$OUTPUT_FILE"

# root = Pathname.new(__dir__).join('../settings')

# json_path = root.join('script_directories.json')

# # Fetch the pre-generated header that Raycast has in its files for some reason.
# header = root.join('header.bin').binread

# # Zip the settings
# zip = TTY::Command.new(printer: :null, binmode: true).run!('gzip', '-c', json_path.to_s).out

# # Put it both together
# combined_content = header + zip

# # Encrypt it to a file on the Desktop
# rayconfig_path = Pathname.new('~/Desktop/script_directories.rayconfig').expand_path
# TTY::Command.new(printer: :null, binmode: true).run!('openssl', 'enc',
#                                                      '-e', '-aes-256-cbc',
#                                                      '-nosalt',
#                                                      '-k', '12345678',
#                                                      '-out', rayconfig_path.to_s,
#                                                      input: combined_content)

# system('open ~/Desktop/')
