module Core
  module Employee
    class Employee
      attr_accessor :id, :name, :address, :payment_classification

      def initialize(id, name, address, pc)
        @id = id
        @name = name
        @address = address
        @payment_classification = pc
      end

      def to_hash
        {
          :id => @id,
          :name => @name,
          :address => @address,
          :payment_classification => @payment_classification.to_hash
        }
      end
    end
  end
end
