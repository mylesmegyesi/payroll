require 'payroll_core/payment_classification/hourly'

describe PaymentClassification::Hourly do

  it 'sets the id' do
    pc = PaymentClassification::Hourly.new(10, nil)
    pc.id.should == 10 
  end

  it 'sets the hourly rate' do
    pc = PaymentClassification::Hourly.new(nil, 10)
    pc.rate.should == 10
  end

  it 'converts itself to a hash' do
    pc = PaymentClassification::Hourly.new(1, 10)
    pc.to_hash.should == {:type => 'hourly', :id => 1, :rate => 10}
  end

end
