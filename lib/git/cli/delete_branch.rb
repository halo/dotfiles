module Git
  module CLI
    module DeleteBranch
      def self.call(name)
        puts "Deleting branch #{name}"
        return if Git::Runtime.dry_mode?

        system "git branch -D #{name} &> /dev/null"
      end
    end
  end
end
