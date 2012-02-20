require 'payroll_core/employee/employee'
require 'payroll_core/employee/validator'
require 'payroll_core/payment_classification/validator'
require 'payroll_core/payment_classification/factory'
require 'payroll_core/error/validation_error'

module Employee
  class AddEmployee

    def initialize(datastore_factory)
      @create_employee = datastore_factory.create(:create_employee)
    end

    def execute(employee)
      employee ||= {}
      employee_errors = Validator.validate(employee)
      pc = employee[:payment_classification]
      pc_errors = PaymentClassification::Validator.validate(pc)
      unless employee_errors.empty? && pc_errors.empty?
        employee_errors[:payment_classification] = pc_errors
        raise ValidationError.new(employee_errors) 
      end
      pc = PaymentClassification::Factory.create(pc)
      emp = Employee.new(nil, employee[:name], employee[:address], pc)
      @create_employee.execute(emp)
      return emp
    end
 
  end
end
