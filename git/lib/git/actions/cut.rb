module Git
  module Actions
    # See https://github.com/not-an-aardvark/git-delete-squashed/blob/master/bin/git-delete-squashed.js
    class Cut
      def call
        Git::Requires::InitializedRepository.call
        Git::Requires::CleanWorkingTree.call
        current_branch = Git::Query::CurrentBranchName.call
        Git::CLI::CheckoutMaster.call
        delete_merged_branches
        delete_squashed_branches
        Git::CLI::CheckoutBranch.call(name: current_branch)
      end

      private

      def delete_merged_branches
        Git::Query::MergedLocalBranches.each do |branch|
          Prompt.debug "Processing merged local branch #{branch}..."
          if Git::Runtime.dry_mode?
            Prompt.info "Branch #{branch} is merged into master and can be deleted"
          else
            Git::CLI::ForceDeleteBranch.call(branch)
          end
        end
      end

      def delete_squashed_branches
        Git::Query::LocalBranches.each do |branch|
          Prompt.debug "Processing local branch #{branch}..."
          # Find best common ancestor of branch and master
          base = `git merge-base master #{branch}`.chomp
          # What is this?
          thing = `git rev-parse #{branch}^{tree}`.chomp
          # Faking a commit
          commit = `git commit-tree #{thing} -p #{base} -m _`
          # Commits yet to be applied to master
          diff = `git cherry master #{commit}`

          next unless diff.start_with?('-')

          if Git::Runtime.dry_mode?
            Prompt.info "Branch #{branch} is merged into master and can be deleted"
          else
            Git::CLI::ForceDeleteBranch.call(branch)
          end
        end
      end
    end
  end
end
