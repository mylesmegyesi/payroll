require 'mock/payment_classification'

module Mock
  class Employee
    attr_accessor :id, :payment_classification

    def initialize
      @payment_classification = Mock::PaymentClassification.new
    end
  end
end
