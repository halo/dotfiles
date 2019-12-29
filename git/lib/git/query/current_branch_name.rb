module Git
  module Query
    module CurrentBranchName
      def self.call
        `git symbolic-ref --short HEAD`.chomp
      end
    end
  end
end
