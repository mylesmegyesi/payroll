module Core
  module PaymentClassification
    class Hourly
      attr_accessor :id, :rate

      def initialize(id, rate)
        @id = id
        @rate = rate
      end

      def to_hash
        {
          :classification => 'hourly',
          :id => @id,
          :rate => @rate
        }
      end
    end
  end
end
