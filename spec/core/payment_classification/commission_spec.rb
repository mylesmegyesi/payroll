require 'core/payment_classification/commission'

describe Core::PaymentClassification::Commission do

  it 'sets the id' do
    pc = Core::PaymentClassification::Commission.new(10, nil, nil)
    pc.id.should == 10
  end
  
  it 'sets the salary' do
    pc = Core::PaymentClassification::Commission.new(nil, 10, nil)
    pc.salary.should == 10
  end

  it 'sets the rate' do
    pc = Core::PaymentClassification::Commission.new(nil, nil, 20)
    pc.rate == 20
  end

  it 'converts itself to a hash' do
    pc = Core::PaymentClassification::Commission.new(1, '10000', '20')
    pc.to_hash.should == {:type => 'commission', :id => 1, :salary => '10000', :rate => '20'}
  end

end
