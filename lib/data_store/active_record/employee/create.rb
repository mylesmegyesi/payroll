require 'data_store/active_record/transaction'
require 'data_store/active_record/models/employee'
require 'data_store/active_record/models/payment_classification'

module DataStore
  module AR
    module Employee
      class Create < Transaction

        def execute(employee)
          emp_hash = employee.to_hash
          pc = emp_hash[:payment_classification]
          emp_hash.delete(:payment_classification)
          emp_hash[:payment_classification_attributes] = pc
          ar_emp = DataStore::AR::Models::Employee.create!(emp_hash)
          employee.id = ar_emp.id
          employee.payment_classification.id = ar_emp.payment_classification.id
        end
      
      end
    end
  end
end
