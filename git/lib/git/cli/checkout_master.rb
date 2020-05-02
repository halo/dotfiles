module Git
  module CLI
    module CheckoutMaster
      def self.call
        ::Git::CLI::CheckoutBranch.call name: 'master'
      end
    end
  end
end
