require 'core/payment_classification/salary'

describe Core::PaymentClassification::Salary do

  it 'sets the id' do
    pc = Core::PaymentClassification::Salary.new(10, nil)
    pc.id.should == 10
  end
  
  it 'sets the salary' do
    pc = Core::PaymentClassification::Salary.new(nil, 10)
    pc.salary.should == 10
  end

  it 'converts itself to a hash' do
    pc = Core::PaymentClassification::Salary.new(1, 10)
    pc.to_hash.should == {:classification => 'salary', :id => 1, :salary => 10}
  end
end
