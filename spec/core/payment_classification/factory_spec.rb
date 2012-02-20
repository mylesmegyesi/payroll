require 'core/payment_classification/factory'
require 'core/payment_classification/hourly'
require 'core/payment_classification/salary'
require 'core/payment_classification/commission'

describe Core::PaymentClassification::Factory do

  it 'returns an Hourly for hourly' do
    hourly = Core::PaymentClassification::Factory.create({:type => 'hourly', :rate => '10', :id => 10})
    hourly.class.should == Core::PaymentClassification::Hourly
    hourly.id.should == 10
    hourly.rate.should == '10'
  end

  it 'returns a Salary for salary' do
    salary = Core::PaymentClassification::Factory.create({:type => 'salary', :salary => '100000', :id => 1})
    salary.class.should == Core::PaymentClassification::Salary
    salary.id.should == 1
    salary.salary.should == '100000'
  end

  it 'returns a Commision for commission' do
    comm = Core::PaymentClassification::Factory.create({:type => 'commission', :rate => '10', :salary => '10000', :id => 1})
    comm.class.should == Core::PaymentClassification::Commission
    comm.id.should == 1
    comm.rate.should == '10'
    comm.salary.should == '10000'
  end

  it 'returns nil for an unrecognized pc type' do
    Core::PaymentClassification::Factory.create({:type => ''}).should be_nil
  end

end
