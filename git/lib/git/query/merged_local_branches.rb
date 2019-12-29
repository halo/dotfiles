module Git
  module Query
    module MergedLocalBranches
      def self.each(&block)
        list = `git for-each-ref --merged #{CurrentBranchName.call} refs/heads/ "--format=%(refname:short)"`
        list.chomp.split("\n").reject { |name| name == CurrentBranchName.call }.each(&block)
      end
    end
  end
end
