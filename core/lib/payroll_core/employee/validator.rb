require 'active_model'

module Employee
  
  module Validator

    def self.validate(employee)
      emp = ActiveModelEmployee.new(employee[:name], employee[:address])
      emp.valid?
      emp.errors.to_hash
    end
    
    private

    class ActiveModelEmployee
      include ActiveModel::Validations 
      attr_reader :name, :address

      validates :name, :presence => true
      validates :address, :presence => true

      def initialize(name, address)
        @name = name
        @address = address
      end

    end
  end

end
