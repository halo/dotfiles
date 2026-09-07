# frozen_string_literal: true

module Git
  module Query
    module CleanWorkingTree
      def self.call
        Prompt.debug 'Checking if working tree is clean...'

        `git status --porcelain`.chomp == ''
      end
    end
  end
end
