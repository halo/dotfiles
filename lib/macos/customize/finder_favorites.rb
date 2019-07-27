module MacOS
  module Customize
    class FinderFavorites
      def call
        return unless mysides_is_installed

        home = Pathname.new('~').expand_path

        add path: home
        add path: home.join('Desktop')
        add path: home.join('Downloads')
        add path: home.join('Documents')
        add path: home.join('Pictures')
        add path: home.join('Music')
        add path: '/Applications'
      end

      private

      def mysides_is_installed
        check = Check.new good: 'Cask `mysides` is available'

        if File.exist?(executable)
          true
        else
          check.conflict! 'run `brew cask install mysides`'
          false
        end
      end

      def ensure_home_directory
      end

      def executable
        '/usr/local/bin/mysides'
      end

      def exists?(url:)
        Command.new(executable, 'list').include?("#{url}/\n")
      end

      def add(path:)
        caption = Pathname.new(path).basename
        check = Check.new good: "Finder Sidebar contains #{caption}"
        url = URI.join('file:///', path.to_s).to_s.sub('file:/', 'file:///')
        return check.pass! if exists?(url: url.to_s)

        # `insert` does not appear to work
        Command.new(executable, 'add', caption, url).run
        check.fixed!
      end

      def home_directory

      end
    end
  end
end
