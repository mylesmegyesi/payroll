require 'data_store/in_memory/employee/create'
require 'mock/employee'

describe DataStore::InMemory::Employee::Create do

  after :each do
    DataStore::InMemory::Transaction.reset
  end

  it 'adds the employee to the employee bucket' do
    ce = DataStore::InMemory::Employee::Create.new
    employee = Mock::Employee.new
    ce.execute(employee)
    DataStore::InMemory::Transaction.get_bucket(:employee)[0].should == employee
  end

  it 'adds an id to the employee' do 
    ce = DataStore::InMemory::Employee::Create.new
    employee = Mock::Employee.new
    ce.execute(employee)
    employee.id.should == 1
  end

  it 'adds an id to the payment_classification' do
    ce = DataStore::InMemory::Employee::Create.new
    employee = Mock::Employee.new
    ce.execute(employee)
    employee.payment_classification.id.should == 1
  end

end
