require 'git'

module Git
  module Requires
    class InitializedRepository
      def self.call
        return if Git::Query::InitializedRepository.call
        Git::Prompt.error 'This is not a git repository.'
        abort
      end
    end
  end
end
