module Git
  module Query
    module LocalBranches
      def self.each(&block)
        `git for-each-ref refs/heads/ "--format=%(refname:short)"`.chomp.split("\n").each(&block)
      end
    end
  end
end
