require 'payroll/payment_classification/salary'

describe Payroll::PaymentClassification::Salary do

  it 'sets the id' do
    pc = Payroll::PaymentClassification::Salary.new(10, nil)
    pc.id.should == 10
  end
  
  it 'sets the salary' do
    pc = Payroll::PaymentClassification::Salary.new(nil, 10)
    pc.salary.should == 10
  end

  it 'converts itself to a hash' do
    pc = Payroll::PaymentClassification::Salary.new(1, 10)
    pc.to_hash.should == {:type => 'salary', :id => 1, :salary => 10}
  end
end
