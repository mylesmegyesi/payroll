require 'data_store/active_record/spec_helper'
require 'data_store/active_record/employee/find_by_id'

describe DataStore::AR::Employee::FindByID do

  after :each do
    DataStore::AR::Models::Employee.destroy_all
  end

  it 'returns a domain model representation of the first employee that matches' do
    emp = DataStore::AR::Models::Employee.create!(:name => 'blah', :address => 'thing')
    find = DataStore::AR::Employee::FindByID.new
    ret_emp = find.execute(emp.id)
    ret_emp.class.should == Core::Employee::Employee
    ret_emp.id.should == emp.id
    ret_emp.name.should == emp.name
    ret_emp.address.should == emp.address
  end
  
  it 'returns a domain model representation of the associated hourly payment classification' do
    emp = DataStore::AR::Models::Employee.create!(:name => 'blah', :address => 'thing', :payment_classification_attributes => {:rate => '50', :classification => 'hourly'})
    find = DataStore::AR::Employee::FindByID.new
    ret_emp = find.execute(emp.id)
    ret_emp.payment_classification.class.should == Core::PaymentClassification::Hourly
    ret_emp.payment_classification.id.should == emp.payment_classification.id
    ret_emp.payment_classification.rate.should == emp.payment_classification.rate
  end
  
  it 'returns a domain model representation of the associated salary payment classification' do
    emp = DataStore::AR::Models::Employee.create!(:name => 'blah', :address => 'thing', :payment_classification_attributes => {:salary => '50', :classification => 'salary'})
    find = DataStore::AR::Employee::FindByID.new
    ret_emp = find.execute(emp.id)
    ret_emp.payment_classification.class.should == Core::PaymentClassification::Salary
    ret_emp.payment_classification.id.should == emp.payment_classification.id
    ret_emp.payment_classification.salary.should == emp.payment_classification.salary
  end
  
  it 'returns a domain model representation of the associated commission payment classification' do
    emp = DataStore::AR::Models::Employee.create!(:name => 'blah', :address => 'thing', :payment_classification_attributes => {:salary => '50', :rate => '50', :classification => 'commission'})
    find = DataStore::AR::Employee::FindByID.new
    ret_emp = find.execute(emp.id)
    ret_emp.payment_classification.class.should == Core::PaymentClassification::Commission
    ret_emp.payment_classification.id.should == emp.payment_classification.id
    ret_emp.payment_classification.salary.should == emp.payment_classification.salary
    ret_emp.payment_classification.rate.should == emp.payment_classification.rate
  end
  
  it 'returns nil when the record is not found' do
    find = DataStore::AR::Employee::FindByID.new
    ret_emp = find.execute(0)
    ret_emp.should be_nil
  end

end