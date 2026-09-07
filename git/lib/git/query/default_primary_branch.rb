# frozen_string_literal: true

module Git
  module Query
    # Returns "main" or "master".
    module DefaultPrimaryBranch
      def self.call
        Prompt.debug 'Querying default primary branch name...'

        # Prefer origin/HEAD if it exists (handles main/master and any custom default)
        primary = `git rev-parse --abbrev-ref origin/HEAD 2>/dev/null`.chomp
        if $?.success? && !primary.empty? && primary != 'origin/HEAD' && primary.start_with?('origin/')
          # primary is like "origin/main" or "origin/master"
          return primary.sub(%r{\Aorigin/}, '')
        end

        # Fallback: check local branches when origin/HEAD is not set (e.g. no remote)
        return 'main' if branch_exists?('main')
        return 'master' if branch_exists?('master')

        # Last resort: check remote branches
        return 'main' if branch_exists?('origin/main')
        return 'master' if branch_exists?('origin/master')

        # Default to main for new repos
        'main'
      end

      def self.branch_exists?(name)
        system("git show-ref --verify --quiet refs/heads/#{name} 2>/dev/null") ||
          system("git show-ref --verify --quiet refs/remotes/#{name} 2>/dev/null")
      end
      private_class_method :branch_exists?
    end
  end
end
