require 'git'

module Git
  module Requires
    class CleanWorkingTree
      def self.call
        return if Git::Query::CleanWorkingTree.call

        Git::Prompt.error 'Your current branch is dirty.'
        abort
      end
    end
  end
end
