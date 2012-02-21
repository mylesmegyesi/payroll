require 'data_store/active_record/spec_helper'
require 'data_store/active_record/transaction_factory'

describe DataStore::AR::TransactionFactory do

  it 'returns Employee::Create for :create_employee' do
    factory = DataStore::AR::TransactionFactory.new
    ce = factory.create(:create_employee)
    ce.class.should == DataStore::AR::Employee::Create
  end

  it 'returns Employee::DeleteById for :delete_employee_by_id' do
    factory = DataStore::AR::TransactionFactory.new
    ce = factory.create(:delete_employee_by_id)
    ce.class.should == DataStore::AR::Employee::DeleteByID
  end

  it 'returns Employee::FindById for :find_employee_by_id' do
    factory = DataStore::AR::TransactionFactory.new
    ce = factory.create(:find_employee_by_id)
    ce.class.should == DataStore::AR::Employee::FindByID
  end
  
  it 'returns nil for an unrecognized name' do
    factory = DataStore::AR::TransactionFactory.new
    factory.create(:asdf).should be_nil
  end

end
