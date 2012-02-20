require 'in_memory/transaction/create_employee'

module Transaction

  class Factory

    def create(name)
      case name
      when :create_employee
        Transaction::CreateEmployee.new
      end
    end

  end

end
