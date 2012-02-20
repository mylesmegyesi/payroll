module Payroll
  module PaymentClassification
    class Hourly
      attr_accessor :id, :rate

      def initialize(id, rate)
        @id = id
        @rate = rate
      end

      def to_hash
        {
          :type => 'hourly',
          :id => @id,
          :rate => @rate
        }
      end
    end
  end
end
