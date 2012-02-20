require 'in_memory/transaction/factory'

describe Transaction::Factory do

  it 'returns CreateEmployee for :create_employee' do
    factory = Transaction::Factory.new
    ce = factory.create(:create_employee)
    ce.class.should == Transaction::CreateEmployee
  end

  it 'returns nil for an unrecognized name' do
    factory = Transaction::Factory.new
    factory.create(:asdf).should be_nil
  end

end
