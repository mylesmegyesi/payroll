require 'data_store/in_memory/employee/create'
require 'data_store/in_memory/employee/delete_by_id'
require 'data_store/in_memory/employee/find_by_id'

module DataStore
  module InMemory
    class TransactionFactory

      def create(name)
        case name
        when :create_employee
          DataStore::InMemory::Employee::Create.new
        when :delete_employee_by_id
          DataStore::InMemory::Employee::DeleteByID.new
        when :find_employee_by_id
          DataStore::InMemory::Employee::FindByID.new
        end
      end

    end
  end
end
