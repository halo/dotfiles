module Git
  module Query
    module MergedLocalBranches
      def self.each(&block)
        current_branch = CurrentBranchName.call

        list = `git for-each-ref --merged #{current_branch} refs/heads/ "--format=%(refname:short)"`
        list.chomp.split("\n").reject { |name| name == current_branch }.each(&block)
      end
    end
  end
end
