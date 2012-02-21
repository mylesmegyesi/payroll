require 'data_store/active_record/spec_helper'
require 'data_store/active_record/employee/create'
require 'data_store/active_record/models/employee'
require 'core/employee/employee'
require 'core/payment_classification/hourly'

describe DataStore::AR::Employee::Create do

  after :each do
    DataStore::AR::Models::Employee.destroy_all
  end

  it 'adds the employee to the database' do
    ce = DataStore::AR::Employee::Create.new
    pc = Core::PaymentClassification::Hourly.new(nil, '50')
    employee = Core::Employee::Employee.new(nil, 'name', 'address', pc)
    ce.execute(employee)
    emp = DataStore::AR::Models::Employee.find(:all).first
    emp.name.should == 'name'
    emp.address.should == 'address'
  end

  it 'adds the associated payment classification to the database' do
    ce = DataStore::AR::Employee::Create.new
    pc = Core::PaymentClassification::Hourly.new(nil, '50')
    employee = Core::Employee::Employee.new(nil, 'name', 'address', pc)
    ce.execute(employee)
    emp = DataStore::AR::Models::Employee.find(:all).first
    emp.payment_classification.rate.should == '50'
    emp.payment_classification.classification.should == 'hourly'
  end
  
  it 'adds an id to the employee' do 
    ce = DataStore::AR::Employee::Create.new
    pc = Core::PaymentClassification::Hourly.new(nil, '50')
    employee = Core::Employee::Employee.new(nil, 'name', 'address', pc)
    ce.execute(employee)
    employee.id.should_not be_nil
  end

  it 'adds an id to the payment_classification' do
    ce = DataStore::AR::Employee::Create.new
    pc = Core::PaymentClassification::Hourly.new(nil, '50')
    employee = Core::Employee::Employee.new(nil, 'name', 'address', pc)
    ce.execute(employee)
    employee.payment_classification.id.should_not be_nil
  end
end
