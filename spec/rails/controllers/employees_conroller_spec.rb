require 'rails/spec_helper'
require 'core/employee/interactor/create'
require 'core/employee/employee'
require 'core/payment_classification/hourly'
require 'core/error/validation_error'

describe EmployeesController do

  context 'create' do

    it 'creates an employee and returns the json representation' do
      pc = Core::PaymentClassification::Hourly.new(25, '50')
      emp = Core::Employee::Employee.new(31, 'Jim', '123 Sweet St.', pc)
      Core::Employee::Interactor::Create.any_instance.should_receive(:execute).and_return(emp)
      pc_hash = {'type' => 'hourly', 'rate' => pc.rate}
      emp_hash = {'name' => emp.name, 'address' => emp.address, 'payment_classification' => pc_hash}
      post :create, :employee => emp_hash
      emp_hash['id'] = emp.id
      emp_hash['payment_classification']['id'] = pc.id
      json_response = JSON.parse(response.body)
      json_response.should == emp_hash
    end

    it 'upon a validation error returns the original request with an errors key appended' do
      errors = {'yo_mamma_said' => 'not enough cool aid'}
      Core::Employee::Interactor::Create.any_instance.should_receive(:execute).and_raise(Core::Error::ValidationError.new(errors))
      pc_hash = {'type' => 'hourly', 'rate' => '50'}
      emp_hash = {'name' => 'Jimmy', 'address' => 'The Louve', 'payment_classification' => pc_hash}
      post :create, :employee => emp_hash
      json_response = JSON.parse(response.body)
      json_response.should include('errors')
      json_response['errors'].should == errors
    end

    it 'handles nil input' do 
      errors = {'yo_mamma_said' => 'not enough cool aid'}
      Core::Employee::Interactor::Create.any_instance.should_receive(:execute).and_raise(Core::Error::ValidationError.new(errors))
      post :create
      json_response = JSON.parse(response.body)
      json_response.should include('errors')
      json_response['errors'].should == errors
    end

  end

  context 'delete' do
  
    it 'deletes an employee and returns success' do
      pc_hash = {:type => 'hourly', :rate => '50'}
      emp_hash = {:name => 'name', :address => 'address', :payment_classification => pc_hash}
      create = Core::Employee::Interactor::Create.new(TRANSACTION_FACTORY)
      emp = create.execute(emp_hash)
      delete :destroy, :id => emp.id
      TRANSACTION_FACTORY.create(:find_employee_by_id).execute(emp.id).should be_nil
      json_response = JSON.parse(response.body)
      json_response.should == {'success' => true}
    end

    it 'returns a failure when record not found' do
      delete :destroy, :id => 0
      json_response = JSON.parse(response.body)
      json_response['success'].should == false
    end

    it 'returns a message key with an error message' do
      delete :destroy, :id => 0
      json_response = JSON.parse(response.body)
      json_response['message'].should_not be_nil 
    end

  end
end
