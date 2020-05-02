module Git
  module Query
    module CurrentBranchName
      def self.call
        Prompt.debug 'Querying current branch name...'

        branch_name = `git symbolic-ref --short HEAD`.chomp
        Prompt.debug "The current branch is #{branch_name}"
        branch_name
      end
    end
  end
end
