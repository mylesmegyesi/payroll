require 'data_store/in_memory/transaction_factory'
require 'data_store/in_memory/employee/create'

describe DataStore::InMemory::TransactionFactory do

  it 'returns Employee::Create for :create_employee' do
    factory = DataStore::InMemory::TransactionFactory.new
    ce = factory.create(:create_employee)
    ce.class.should == DataStore::InMemory::Employee::Create
  end

  it 'returns Employee::DeleteById for :delete_employee_by_id' do
    factory = DataStore::InMemory::TransactionFactory.new
    ce = factory.create(:delete_employee_by_id)
    ce.class.should == DataStore::InMemory::Employee::DeleteByID
  end

  it 'returns Employee::FindById for :find_employee_by_id' do
    factory = DataStore::InMemory::TransactionFactory.new
    ce = factory.create(:find_employee_by_id)
    ce.class.should == DataStore::InMemory::Employee::FindByID
  end
  
  it 'returns nil for an unrecognized name' do
    factory = DataStore::InMemory::TransactionFactory.new
    factory.create(:asdf).should be_nil
  end

end
