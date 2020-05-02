module Git
  module CLI
    module CheckoutBranch
      def self.call(name:)
        return if Query::CurrentBranchName.call == name

        Prompt.separator
        Prompt.info "Checking out branch #{name}..."
        Prompt.separator
        system %(git checkout "#{name}" &> /dev/null)
      end
    end
  end
end
