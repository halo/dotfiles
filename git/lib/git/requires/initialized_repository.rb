# frozen_string_literal: true

require 'git'

module Git
  module Requires
    # Exits program if we're not inside a git repository.
    class InitializedRepository
      def self.call
        return if Git::Query::GitMetadataDirectoyPath.call

        Git::Prompt.error 'This is not a git repository.'
        abort
      end
    end
  end
end
