require 'in_memory/transaction'
require 'in_memory/transaction_factory'
require 'payroll/employee/employee'
require 'payroll/employee/interactor/delete_by_id'
require 'payroll/payment_classification/hourly'
require 'payroll/error/record_not_found'

describe Payroll::Employee::Interactor::DeleteByID do

  before :each do
    @del_emp = Payroll::Employee::Interactor::DeleteByID.new(InMemory::TransactionFactory.new)
  end

  after :each do
    InMemory::Transaction.reset
  end

  it 'throws a record not found if the given employee id is unrecognized' do
    lambda {@del_emp.execute(0)}.should raise_error(Payroll::Error::RecordNotFound)    
  end

  it 'deletes the matching record' do
    pc = Payroll::PaymentClassification::Hourly.new(nil, 1)
    emp = Payroll::Employee::Employee.new(nil, 'name', 'addr', pc)
    InMemory::Transaction.add(:employee, emp)
    @del_emp.execute(emp.id)
    InMemory::Transaction.get_bucket(:employee).count.should == 0
  end

end
