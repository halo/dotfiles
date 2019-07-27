module MacOS
  module Customize
    # TODO
    class Chromex
      def call
        return unless leveldb
        return unless db
        return check.skip!('Extension not installed') unless path.exist?

        data = read

        if data[:settings][:activeMode][:value] && !data[:settings][:showNumOfCookiesInIcon][:value]
          return check.pass!
        end

        data[:settings][:activeMode][:value] = true
        data[:settings][:domainChangeCleanup][:value] = true

        data[:settings][:showNumOfCookiesInIcon][:value] = false
        data[:settings][:showNotificationAfterCleanup][:value] = false

        save
      end

      private

      def leveldb
        require 'leveldb'
        true
      rescue LoadError => exception
        check.conflict! 'leveldb not installed'
        false
      end

      def extension_id
        'fhcgjolkccmbidfldomjliifgaodjagh'
      end

      def db
        LevelDB::DB.new path.expand_path.to_s
      rescue LevelDB::DB::Error => exception
        puts exception.message if Runtime.debug_mode?
        check.chrome_conflict!
        nil
      end

      def read
        JSON.parse db['state'].undump, symbolize_names: true
      end

      def save
        db.put 'state', data.to_json.dump
      end

      def path
        Pathname.new('~/Library/Application Support/Google/Chrome/Default/Local Extension Settings')
                .join(extension_id)
                .expand_path
      end

      def check
        @check ||= Check.new good: 'Chrome Cookie Deletion is activated'
      end
    end
  end
end
