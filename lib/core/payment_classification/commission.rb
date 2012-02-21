module Core
  module PaymentClassification
    class Commission
      attr_accessor :id, :salary, :rate

      def initialize(id, salary, rate)
        @id = id
        @salary = salary
        @rate = rate
      end

      def to_hash
        {
          :classification => 'commission',
          :id => @id,
          :salary => @salary,
          :rate => @rate
        }
      end
    end
  end
end
