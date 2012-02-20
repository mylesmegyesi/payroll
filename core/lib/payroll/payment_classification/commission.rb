module Payroll
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
          :type => 'commission',
          :id => @id,
          :salary => @salary,
          :rate => @rate
        }
      end
    end
  end
end
