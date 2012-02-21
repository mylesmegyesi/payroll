require 'data_store/active_record/employee/create'
require 'data_store/active_record/employee/delete_by_id'
require 'data_store/active_record/employee/find_by_id'

module DataStore
  module AR
    class TransactionFactory

      def create(name)
        case name
        when :create_employee
          DataStore::AR::Employee::Create.new
        when :delete_employee_by_id
          DataStore::AR::Employee::DeleteByID.new
        when :find_employee_by_id
          DataStore::AR::Employee::FindByID.new
        end
      end

    end
  end
end
