module Git
  module CLI
    module CheckoutMaster
      def self.call
        Prompt.separator
        Prompt.info 'Checking out master...'
        Prompt.separator
        system 'git checkout master &> /dev/null'
      end
    end
  end
end
