# MIT License
#
# Copyright (c) 2019-2020 halo - https://github.com/halo/founder
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'logger'
require 'pathname'
require 'rubygems/commands/install_command'

module Founder
  # General settings for Founder.
  class Configuration
    attr_writer :gemfile_path, :download_path
    attr_accessor :bundler_version, :logger, :debug

    def initialize
      self.gemfile_path = ::File.expand_path('../vendor/Gemfile', __dir__)
      self.bundler_version = '2.0.1'
      self.debug = ARGV.dup.delete('--debug') || ENV['DEBUG']
      self.logger = debug ? ::Logger.new($stdout) : ::Logger.new('/dev/null')
    end

    def gemfile_path
      ::Pathname.new @gemfile_path
    end

    def gemfile_lock_path
      gemfile_path.sub_ext '.lock'
    end

    def download_path
      return ::Pathname.new(@download_path) if @download_path

      gemfile_path.parent
    end

    # This is the same implementation that `Gem.default_dir` and `Bundler.ruby_scope` have.
    # Every gem we install is scoped by the ruby engine and version to ensure compatibility.
    def gems_path
      download_path.join "#{Gem.ruby_engine}/#{RbConfig::CONFIG['ruby_version']}"
    end

    def bundler_lib_path
      gem_path(name: :bundler, version: bundler_version).join 'lib'
    end

    def gem_path(name:, version:)
      gems_path.join 'gems', "#{name}-#{version}"
    end
  end
end

module Founder
  # Obtains the `bundler` gem.
  class Bundler
    def call
      if config.bundler_lib_path.exist?
        logger.info { "Bundler is available at #{config.bundler_lib_path}" }
        return
      end

      logger.debug { "Installing Bundler #{config.bundler_version} to `#{config.gems_path}`" }
      download
    end

    private

    def download
      capture_output { command.execute }
    rescue ::Gem::SystemExitException => exception
      if exception.exit_code.zero?
        logger.debug { 'Successfully installed bundler.' }
      else
        logger.debug { 'Could not install bundler. Raising underlying exception...' }
        raise
      end
    end

    def capture_output(&block)
      yield if config.debug
      ::Gem::DefaultUserInteraction.use_ui ::Gem::SilentUI.new, &block
    end

    def command
      result = ::Gem::Commands::InstallCommand.new
      result.handle_options options
      result
    end

    # Either `--no-ri --no-rdoc` or `--no-documentation` should also be used.
    # But that may lead to errors depending on the RubyGems version.
    def options
      %W[bundler --version #{config.bundler_version} --install-dir #{config.gems_path}]
    end

    def config
      Founder.config
    end

    def logger
      config.logger
    end
  end
end

module Founder
  # Runs `bundle install` to download gems specified in Gemfile.
  class Bundle
    def call
      sanity_check
      load_bundler
      silence_bundler_warnings
      run
      logger.info { 'All dependencies are satisfied.' }
    end

    private

    def sanity_check
      config.gemfile_path.exist? || cancel(2, "Founder error: expected #{config.gemfile_path} to exist.")
      config.gemfile_lock_path.exist? || cancel(3, "Founder error: expected #{config.gemfile_lock_path} to exist.")
    end

    def load_bundler
      logger.debug { "Adding bundler to $LOAD_PATH from `#{config.bundler_lib_path}`" }
      $LOAD_PATH.unshift config.bundler_lib_path.to_s
      logger.debug { "This is your $LOAD_PATH: `#{$LOAD_PATH}`" }
      require 'bundler/cli'
      require 'bundler/cli/install'
      logger.debug { 'Bundler is now loaded.' }
    end

    # To hide the warning "The latest bundler is ..., but you are currently running ..."
    def silence_bundler_warnings
      return if config.debug

      ::Bundler::UI::Shell.class_eval { def warn(*); end }
    end

    def run
      logger.info { 'Ensuring dependencies...' }
      logger.debug { "Bundler uses Gemfile `#{config.gemfile_path}`" }
      logger.debug { "Bundler will download gems into `#{config.gems_path}`" }
      ::Bundler::CLI.start arguments
    end

    def arguments
      result = %W[--deployment --jobs 4 --gemfile #{config.gemfile_path} --path #{config.download_path}]
      result.push('--quiet') unless config.debug
      result
    end

    def config
      Founder.config
    end

    def logger
      config.logger
    end

    def cancel(code, message)
      logger.fatal { message }
      exit code
    end
  end
end

# Public API.
module Founder
  # To identify later which code version you copy-and-pasted.
  def self.version
    '0.0.3'
  end

  def self.install
    raise 'Unsupported Ruby version' unless RUBY_VERSION.to_f >= 2.3

    download
    setup
  end

  def self.download
    ::Founder::Bundler.new.call
    ::Founder::Bundle.new.call
  end

  def self.setup
    require 'bundler'
    ::Bundler.setup
  end

  def self.config
    @config ||= ::Founder::Configuration.new
  end

  def self.configure
    yield config
  end
end
