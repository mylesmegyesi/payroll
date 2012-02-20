require 'data_store/in_memory/transaction'

module DataStore
  module InMemory
    module Employee
      class Create < Transaction

        def execute(employee)
          emp_id = self.class.get_id(:employee)
          employee.id = emp_id
          pc_id = self.class.get_id(:payment_classification)
          employee.payment_classification.id = pc_id
          self.class.add(:employee, employee)
        end

      end
    end
  end
end
