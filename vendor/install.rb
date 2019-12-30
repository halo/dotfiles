require_relative 'founder'

Founder.config.debug = ARGV.include?('--debug')
Founder.config.gemfile_path = File.expand_path('Gemfile', __dir__)
Founder.install
