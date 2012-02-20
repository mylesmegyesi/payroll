require 'payroll/employee/employee'
require 'payroll/employee/validator'
require 'payroll/payment_classification/validator'
require 'payroll/payment_classification/factory'
require 'payroll/error/validation_error'

module Payroll
  module Employee
    module Interactor
      class Create

        def initialize(datastore_factory)
          @create_employee = datastore_factory.create(:create_employee)
        end

        def execute(employee)
          employee ||= {}
          employee_errors = Payroll::Employee::Validator.validate(employee)
          pc = employee[:payment_classification]
          pc_errors = Payroll::PaymentClassification::Validator.validate(pc)
          unless employee_errors.empty? && pc_errors.empty?
            employee_errors[:payment_classification] = pc_errors
            raise Payroll::Error::ValidationError.new(employee_errors) 
          end
          pc = Payroll::PaymentClassification::Factory.create(pc)
          emp = Payroll::Employee::Employee.new(nil, employee[:name], employee[:address], pc)
          @create_employee.execute(emp)
          return emp
        end

      end
    end
  end
end
