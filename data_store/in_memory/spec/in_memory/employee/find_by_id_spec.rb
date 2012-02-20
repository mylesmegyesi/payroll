require 'in_memory/employee/find_by_id'
require 'mock/employee'

describe InMemory::Employee::FindByID do

  before :each do
    @find = InMemory::Employee::FindByID.new
  end

  after :each do
    InMemory::Transaction.reset
  end

  it 'returns the first employee that matches' do
    emp1 = Mock::Employee.new
    emp1.id = 1
    emp2 = Mock::Employee.new
    emp2.id = 1
    InMemory::Transaction.add(:employee, emp1)
    InMemory::Transaction.add(:employee, emp2)
    @find.execute(1).should == emp1
  end

  it 'returns nil if employee is not found' do
    @find.execute(1).should be_nil
  end

end
