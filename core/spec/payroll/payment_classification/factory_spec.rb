require 'payroll/payment_classification/factory'
require 'payroll/payment_classification/hourly'
require 'payroll/payment_classification/salary'
require 'payroll/payment_classification/commission'

describe Payroll::PaymentClassification::Factory do

  it 'returns an Hourly for hourly' do
    hourly = Payroll::PaymentClassification::Factory.create({:type => 'hourly', :rate => '10', :id => 10})
    hourly.class.should == Payroll::PaymentClassification::Hourly
    hourly.id.should == 10
    hourly.rate.should == '10'
  end

  it 'returns a Salary for salary' do
    salary = Payroll::PaymentClassification::Factory.create({:type => 'salary', :salary => '100000', :id => 1})
    salary.class.should == Payroll::PaymentClassification::Salary
    salary.id.should == 1
    salary.salary.should == '100000'
  end

  it 'returns a Commision for commission' do
    comm = Payroll::PaymentClassification::Factory.create({:type => 'commission', :rate => '10', :salary => '10000', :id => 1})
    comm.class.should == Payroll::PaymentClassification::Commission
    comm.id.should == 1
    comm.rate.should == '10'
    comm.salary.should == '10000'
  end

  it 'returns nil for an unrecognized pc type' do
    Payroll::PaymentClassification::Factory.create({:type => ''}).should be_nil
  end

end
