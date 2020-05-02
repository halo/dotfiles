module Git
  module CLI
    module CheckoutBranch
      def self.call(name:)
        system %(git checkout "#{name}" &> /dev/null)
      end
    end
  end
end
