require 'core/payment_classification/hourly'

describe Core::PaymentClassification::Hourly do

  it 'sets the id' do
    pc = Core::PaymentClassification::Hourly.new(10, nil)
    pc.id.should == 10 
  end

  it 'sets the hourly rate' do
    pc = Core::PaymentClassification::Hourly.new(nil, 10)
    pc.rate.should == 10
  end

  it 'converts itself to a hash' do
    pc = Core::PaymentClassification::Hourly.new(1, 10)
    pc.to_hash.should == {:classification => 'hourly', :id => 1, :rate => 10}
  end

end
