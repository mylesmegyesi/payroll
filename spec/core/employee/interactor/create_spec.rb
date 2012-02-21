require 'data_store/in_memory/transaction'
require 'core/employee/interactor/create'
require 'core/employee/employee'
require 'core/payment_classification/hourly'
require 'core/error/validation_error'

describe Core::Employee::Interactor::Create do

  before :each do
    @add_emp = Core::Employee::Interactor::Create.new(DataStore::InMemory::TransactionFactory.new)
  end

  after :each do
    DataStore::InMemory::Transaction.reset
  end

  context 'valid employee' do
    
    before :each do
      @valid_employee = {
        :name => 'Jim Bob',
        :address => '123 sweet St',
        :payment_classification => {
          :classification => 'hourly',
          :rate => '8.25'
        }
      }
    end

    it 'creates a record in the datastore' do
      ret_emp = @add_emp.execute(@valid_employee)
      DataStore::InMemory::Transaction.get_bucket(:employee).count.should == 1
      created_emp = DataStore::InMemory::Transaction.get_bucket(:employee)[0]
      ret_emp.should == created_emp
    end

    it 'returns an Employee domain model with the correct values' do
      ret_emp = @add_emp.execute(@valid_employee)
      ret_emp.class.should == Core::Employee::Employee
      ret_emp.name.should == @valid_employee[:name]
      ret_emp.address.should == @valid_employee[:address]
      ret_emp.payment_classification.class.should == Core::PaymentClassification::Hourly
      ret_emp.payment_classification.rate.should == '8.25'
    end

  end

  context 'invalid employee' do

    let(:invalid_employee) {{}}

    it 'handles nil input' do
      lambda {@add_emp.execute(nil)}.should raise_error(Core::Error::ValidationError)
    end

    it 'raises a ValidationError' do
      lambda {@add_emp.execute(invalid_employee)}.should raise_error(Core::Error::ValidationError)
    end
  
    it 'does not create a record in the data store' do 
      begin
        ret_emp = @add_emp.execute(invalid_employee)
      rescue Core::Error::ValidationError
      end
      DataStore::InMemory::Transaction.get_bucket(:employee).count.should == 0
    end

    it 'returns the validation errors for Employee and PaymentClassification' do
      begin
        ret_emp = @add_emp.execute(invalid_employee)
      rescue Core::Error::ValidationError => e
        e.errors.should include(:name)
        e.errors.should include(:address)
        e.errors.should include(:payment_classification)
      end
    end
  
  end
  
end
