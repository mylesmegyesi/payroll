require 'in_memory/transaction/base'
require 'in_memory/transaction/factory'
require 'payroll_core/employee/delete_employee'
require 'error/record_not_found'

describe Employee::DeleteEmployee do

  before :each do
    @del_emp = Employee::DeleteEmployee.new(Transaction::Factory.new)
  end

  after :each do
    Transaction::Base.reset
  end

  it 'throws a record not found if the given employee id is unrecognized' do
    lambda {@del_emp.execute(0)}.should raise_error(RecordNotFound)    
  end

end
