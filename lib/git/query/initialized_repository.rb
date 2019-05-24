module Git
  module Query
    module InitializedRepository
      def self.call
        system('git rev-parse --git-dir &> /dev/null')
      end
    end
  end
end
