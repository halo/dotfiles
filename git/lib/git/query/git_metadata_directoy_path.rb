# frozen_string_literal: true

module Git
  module Query
    # If inside a git repo: prints the path to the `.git` metadata directory (returns String)
    # If not in a git repo: Exits with 128 (returns false)
    module GitMetadataDirectoyPath
      def self.call
        system('git rev-parse --git-dir &> /dev/null')
      end
    end
  end
end
