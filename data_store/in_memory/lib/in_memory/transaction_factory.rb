require 'in_memory/employee/create'
require 'in_memory/employee/delete_by_id'
require 'in_memory/employee/find_by_id'

module InMemory
  class TransactionFactory

    def create(name)
      case name
      when :create_employee
        InMemory::Employee::Create.new
      when :delete_employee_by_id
        InMemory::Employee::DeleteByID.new
      when :find_employee_by_id
        InMemory::Employee::FindByID.new
      end
    end

  end

end
