require 'in_memory/transaction/create_employee'

class MockPC
  attr_accessor :id
end

class MockEmployee
  attr_accessor :id, :payment_classification

  def initialize
    @payment_classification = MockPC.new
  end
end

describe Transaction::CreateEmployee do

  after :each do
    Transaction::Base.reset
  end

  it 'adds the employee to the employee bucket' do
    ce = Transaction::CreateEmployee.new
    employee = MockEmployee.new
    ce.execute(employee)
    Transaction::Base.get_bucket(:employee)[0].should == employee
  end

  it 'adds an id to the employee' do 
    ce = Transaction::CreateEmployee.new
    employee = MockEmployee.new
    ce.execute(employee)
    employee.id.should == 1
  end

  it 'adds an id to the payment_classification' do
    ce = Transaction::CreateEmployee.new
    employee = MockEmployee.new
    ce.execute(employee)
    employee.payment_classification.id.should == 1
  end

end
