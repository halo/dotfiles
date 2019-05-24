module Git
  module CLI
    module CheckoutMaster
      def self.call
        system 'git checkout master &> /dev/null'
      end
    end
  end
end
