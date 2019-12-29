module Git
  module Query
    module CleanWorkingTree
      def self.call
        `git status --porcelain`.chomp == ''
      end
    end
  end
end
