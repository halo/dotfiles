# frozen_string_literal: true

module Git
  module CLI
    module CheckoutPrimaryBranch
      def self.call
        name = ::Git::Query::DefaultPrimaryBranch.call
        ::Git::CLI::CheckoutBranch.call(name: name)
      end
    end
  end
end
