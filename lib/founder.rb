# frozen_string_literal: true

require 'logger'
require 'pathname'
require 'rubygems/commands/install_command'

module Founder
  def self.install(*args)
    ::Founder::Bundler.new(*args).call
    setup
  end

  def self.setup
    require 'bundler'
    ::Bundler.setup
  end

  class Paths
    attr_reader :root

    def initialize(root:)
      @root = Pathname.new(root)
    end

    def gemfile
      root.join('Gemfile')
    end

    # This is the same implementation that `Gem.default_dir` and `Bundler.ruby_scope` have.
    # Every gem we install is scoped by the ruby engine and version to ensure compatibility.
    def gems
      root.join "#{Gem.ruby_engine}/#{RbConfig::CONFIG['ruby_version']}"
    end

    def gem(name: nil, version: nil)
      gems.join 'gems', "#{name}-#{version}"
    end
  end

  class Bundler
    attr_reader :paths, :version, :logger

    def initialize(path: ::File.expand_path('../vendor', __dir__), version: '2.0.1', logger: ::Logger.new(STDOUT))
      @paths = ::Founder::Paths.new(root: path)
      @version = version
      @logger = logger
    end

    def call
      raise 'Unsupported Ruby version' unless RUBY_VERSION.to_f >= 2.3
      download unless bundler_lib.exist?
      run
      logger.info { 'All dependencies are satisfied.' }
    end

    private

    # RubyGems

    def download
      logger.info { 'Downloading bundler...' }
      logger.debug { "Bundler #{version} will be installed in `#{paths.gems}`" }
      capture_gem_output { gem_command.execute }
    rescue ::Gem::SystemExitException => exception
      if exception.exit_code.zero?
        logger.debug { 'Successfully installed bundler.' }
      else
        logger.debug { 'Could not install bundler. Raising underlying exception...' }
        raise
      end
    end

    def capture_gem_output(&block)
      yield if debug?
      ::Gem::DefaultUserInteraction.use_ui ::Gem::SilentUI.new, &block
    end

    def gem_command
      result = ::Gem::Commands::InstallCommand.new
      result.handle_options gem_options
      result
    end

    # In the future `--no-documentation` should be used.
    # But it is not recognized by the ruby version we support as of now.
    def gem_options
      %W[bundler --no-ri --no-rdoc --version #{version} --install-dir #{paths.gems}]
    end

    # Bundler

    def run
      load_bundler
      silence_bundler_warnings
      logger.info { 'Ensuring dependencies...' }
      logger.debug { "Bundler uses Gemfile `#{paths.gemfile}`" }
      logger.debug { "Bundler will download gems into `#{paths.root}`" }
      ::Bundler::CLI.start bundler_arguments
    end

    def load_bundler
      logger.debug { "Adding bundler to $LOAD_PATH from `#{bundler_lib}`" }
      $LOAD_PATH << bundler_lib.to_s
      require 'bundler/cli'
      require 'bundler/cli/install'
      logger.debug { 'Bundler is now loaded.' }
    end

    # To hide the warning "The latest bundler is ..., but you are currently running ..."
    def silence_bundler_warnings
      return if debug?
      ::Bundler::UI::Shell.class_eval { def warn(*); end }
    end

    def bundler_arguments
      result = %W[--deployment --jobs 4 --gemfile #{paths.gemfile} --path #{paths.root}]
      result.push('--quiet') unless debug?
      result
    end

    def debug?
      logger.level >= ::Logger::INFO
    end

    def bundler_lib
      paths.gem(name: :bundler, version: version).join 'lib'
    end
  end
end
