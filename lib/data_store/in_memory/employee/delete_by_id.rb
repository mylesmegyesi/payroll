require 'data_store/in_memory/transaction'

module DataStore
  module InMemory
    module Employee
      class DeleteByID < Transaction 

        def execute(emp_id)
          self.class.get_bucket(:employee).delete_if { | employee |
            employee.id == emp_id
          }
        end

      end
    end
  end
end
