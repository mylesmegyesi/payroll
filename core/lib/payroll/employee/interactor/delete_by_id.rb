require 'payroll/error/record_not_found'

module Payroll
  module Employee
    module Interactor
      class DeleteByID

        def initialize(datastore_factory)
          @ds_factory = datastore_factory
        end

        def execute(emp_id)
          @find_by_id = @ds_factory.create(:find_employee_by_id)
          emp = @find_by_id.execute(emp_id)
          if emp.nil?
            raise Payroll::Error::RecordNotFound.new
          end
          @delete_emp = @ds_factory.create(:delete_employee_by_id)
          @delete_emp.execute(emp_id)
        end
      end
    end
  end
end
