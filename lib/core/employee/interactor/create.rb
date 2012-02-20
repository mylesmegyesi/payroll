require 'core/employee/employee'
require 'core/employee/validator'
require 'core/payment_classification/validator'
require 'core/payment_classification/factory'
require 'core/error/validation_error'

module Core
  module Employee
    module Interactor
      class Create

        def initialize(datastore_factory)
          @create_employee = datastore_factory.create(:create_employee)
        end

        def execute(employee)
          employee ||= {}
          employee_errors = Core::Employee::Validator.validate(employee)
          pc = employee[:payment_classification]
          pc_errors = Core::PaymentClassification::Validator.validate(pc)
          unless employee_errors.empty? && pc_errors.empty?
            employee_errors[:payment_classification] = pc_errors
            raise Core::Error::ValidationError.new(employee_errors) 
          end
          pc = Core::PaymentClassification::Factory.create(pc)
          emp = Core::Employee::Employee.new(nil, employee[:name], employee[:address], pc)
          @create_employee.execute(emp)
          return emp
        end

      end
    end
  end
end
