module Git
  module CLI
    module SafelyDeleteBranch
      def self.call(name)
        puts "Deleting branch #{name}"
        return if Git::Runtime.dry_mode?

        system "git branch -d #{name} &> /dev/null"
      end
    end
  end
end
