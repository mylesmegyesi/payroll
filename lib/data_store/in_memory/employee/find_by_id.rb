require 'data_store/in_memory/transaction'

module DataStore
  module InMemory
    module Employee
      class FindByID < Transaction

        def execute(id)
          self.class.get_bucket(:employee).select { | employee |
            return employee if employee.id == id
          }
          nil
        end

      end
    end
  end
end
