require 'in_memory/transaction'
require 'payroll/employee/interactor/create'
require 'payroll/employee/employee'
require 'payroll/payment_classification/hourly'
require 'payroll/error/validation_error'

describe Payroll::Employee::Interactor::Create do

  before :each do
    @add_emp = Payroll::Employee::Interactor::Create.new(InMemory::TransactionFactory.new)
  end

  after :each do
    InMemory::Transaction.reset
  end

  context 'valid employee' do
    
    before :each do
      @valid_employee = {
        :name => 'Jim Bob',
        :address => '123 sweet St',
        :payment_classification => {
          :type => 'hourly',
          :rate => '8.25'
        }
      }
    end

    it 'creates a record in the datastore' do
      ret_emp = @add_emp.execute(@valid_employee)
      InMemory::Transaction.get_bucket(:employee).count.should == 1
      created_emp = InMemory::Transaction.get_bucket(:employee)[0]
      ret_emp.should == created_emp
    end

    it 'returns an Employee domain model with the correct values' do
      ret_emp = @add_emp.execute(@valid_employee)
      ret_emp.class.should == Payroll::Employee::Employee
      ret_emp.name.should == @valid_employee[:name]
      ret_emp.address.should == @valid_employee[:address]
      ret_emp.payment_classification.class.should == Payroll::PaymentClassification::Hourly
      ret_emp.payment_classification.rate.should == '8.25'
    end

  end

  context 'invalid employee' do

    let(:invalid_employee) {{}}

    it 'handles nil input' do
      lambda {@add_emp.execute(nil)}.should raise_error(Payroll::Error::ValidationError)
    end

    it 'raises a ValidationError' do
      lambda {@add_emp.execute(invalid_employee)}.should raise_error(Payroll::Error::ValidationError)
    end
  
    it 'does not create a record in the data store' do 
      begin
        ret_emp = @add_emp.execute(invalid_employee)
      rescue Payroll::Error::ValidationError
      end
      InMemory::Transaction.get_bucket(:employee).count.should == 0
    end

    it 'returns the validation errors for Employee and PaymentClassification' do
      begin
        ret_emp = @add_emp.execute(invalid_employee)
      rescue Payroll::Error::ValidationError => e
        e.errors.should include(:name)
        e.errors.should include(:address)
        e.errors.should include(:payment_classification)
      end
    end
  
  end
  
end
