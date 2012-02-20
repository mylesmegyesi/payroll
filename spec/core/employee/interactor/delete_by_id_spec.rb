require 'data_store/in_memory/transaction'
require 'data_store/in_memory/transaction_factory'
require 'core/employee/employee'
require 'core/employee/interactor/delete_by_id'
require 'core/payment_classification/hourly'
require 'core/error/record_not_found'

describe Core::Employee::Interactor::DeleteByID do

  before :each do
    @del_emp = Core::Employee::Interactor::DeleteByID.new(DataStore::InMemory::TransactionFactory.new)
  end

  after :each do
    DataStore::InMemory::Transaction.reset
  end

  it 'throws a record not found if the given employee id is unrecognized' do
    lambda {@del_emp.execute(0)}.should raise_error(Core::Error::RecordNotFound)    
  end

  it 'deletes the matching record' do
    pc = Core::PaymentClassification::Hourly.new(nil, 1)
    emp = Core::Employee::Employee.new(nil, 'name', 'addr', pc)
    DataStore::InMemory::Transaction.add(:employee, emp)
    @del_emp.execute(emp.id)
    DataStore::InMemory::Transaction.get_bucket(:employee).count.should == 0
  end

end
