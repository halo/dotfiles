require 'pathname'
require 'json'
require 'leveldb'

module MacOS
  module OS
    class Chromex
      def initialize(extension_id:)
        @extension_id = extension_id
      end

      def test
        path = Pathname.new '~/Library/Application Support/Google/Chrome/Default/Local Extension Settings/fhcgjolkccmbidfldomjliifgaodjagh'

        begin
          db = LevelDB::DB.new path.expand_path.to_s
        rescue LevelDB::DB::Error => exception
          puts 'Database locked. Is Chrome running?'
          raise
        end

        x = JSON.parse db['state'].undump, symbolize_names: true

        p x[:settings]

        x[:settings][:activeMode][:value] = true
        x[:settings][:domainChangeCleanup][:value] = true

        x[:settings][:showNumOfCookiesInIcon][:value] = false
        x[:settings][:showNotificationAfterCleanup][:value] = false

        db.put 'state', x.to_json.dump
        true
      end


    end
  end
end
