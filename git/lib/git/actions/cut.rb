# frozen_string_literal: true

module Git
  module Actions
    # See https://github.com/not-an-aardvark/git-delete-squashed/blob/master/bin/git-delete-squashed.js
    class Cut
      def call
        Git::Requires::InitializedRepository.call
        Git::Requires::CleanWorkingTree.call
        current_branch = Git::Query::CurrentBranchName.call
        Git::CLI::CheckoutPrimaryBranch.call
        delete_merged_branches
        delete_squashed_branches
        Git::CLI::CheckoutBranch.call(name: current_branch)
      end

      private

      def primary_branch
        @primary_branch ||= Git::Query::DefaultPrimaryBranch.call
      end

      def delete_merged_branches
        Git::Query::MergedLocalBranches.each do |branch|
          Prompt.debug "Processing merged local branch #{branch}..."
          if Git::Runtime.dry_mode?
            Prompt.info "Branch #{branch} is merged into #{primary_branch} and can be deleted"
          else
            Git::CLI::ForceDeleteBranch.call(branch)
          end
        end
      end

      def delete_squashed_branches
        Git::Query::LocalBranches.each do |branch|
          next if branch == primary_branch

          Prompt.debug "Processing local branch #{branch}..."
          # Find best common ancestor of branch and primary
          base = `git merge-base #{primary_branch} #{branch} 2>/dev/null`.chomp
          next if base.empty?

          # What is this?
          thing = `git rev-parse #{branch}^{tree}`.chomp
          # Faking a commit
          commit = `git commit-tree #{thing} -p #{base} -m _ 2>/dev/null`.chomp
          next if commit.empty?

          # Commits yet to be applied to primary
          diff = `git cherry #{primary_branch} #{commit} 2>/dev/null`

          next unless diff.start_with?('-')

          if Git::Runtime.dry_mode?
            Prompt.info "Branch #{branch} is merged into #{primary_branch} and can be deleted"
          else
            Git::CLI::ForceDeleteBranch.call(branch)
          end
        end
      end
    end
  end
end
