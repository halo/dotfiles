module Git
  module CLI
    module ForceDeleteBranch
      def self.call(name)
        Prompt.warn "Deleting branch #{name}"
        return if Git::Runtime.dry_mode?

        system "git branch -D #{name} &> /dev/null"
      end
    end
  end
end
