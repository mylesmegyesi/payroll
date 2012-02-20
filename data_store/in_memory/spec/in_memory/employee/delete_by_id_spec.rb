require 'in_memory/employee/delete_by_id'
require 'mock/employee'

describe InMemory::Employee::DeleteByID do

  after :each do
    InMemory::Transaction.reset
  end

  it 'removes the employee from the employee bucket' do
    mock_emp = Mock::Employee.new
    mock_emp.id = 10
    InMemory::Transaction.add(:employee, mock_emp)
    de = InMemory::Employee::DeleteByID.new
    de.execute(10)
    InMemory::Transaction.get_bucket(:employee).should == []
  end

  it 'does nothing if it cant find the employee' do
    mock_emp = Mock::Employee.new
    mock_emp.id = 11
    InMemory::Transaction.add(:employee, mock_emp)
    de = InMemory::Employee::DeleteByID.new
    de.execute(10)
    InMemory::Transaction.get_bucket(:employee).count.should == 1
  end

end
