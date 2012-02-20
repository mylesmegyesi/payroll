require 'core/employee/employee'

class MockPC
  def to_hash
    {:asdf => 'asdf'}
  end
end

describe Core::Employee::Employee do

  it 'sets the id' do
    emp = Core::Employee::Employee.new(1, nil, nil, {})
    emp.id.should == 1
  end
  
  it 'sets the name' do
    emp = Core::Employee::Employee.new(nil, 'name', nil, {})
    emp.name.should == 'name'
  end

  it 'sets the address' do
    emp = Core::Employee::Employee.new(nil, nil, 'addr', {})
    emp.address.should == 'addr'
  end

  it 'sets the payment classification' do 
    emp = Core::Employee::Employee.new(nil, nil, nil, :pc)
    emp.payment_classification.should == :pc
  end

  it 'converts itself to a hash' do
    emp = Core::Employee::Employee.new(1, 'name', 'address', MockPC.new)
    emp.to_hash.should == {:id => 1, :name => 'name', :address => 'address', :payment_classification => {:asdf => 'asdf'}}
  end
end
