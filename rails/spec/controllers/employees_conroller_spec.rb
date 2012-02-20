require 'spec_helper'
require 'payroll_core/employee/add_employee'
require 'payroll_core/employee/employee'
require 'payroll_core/payment_classification/hourly'
require 'payroll_core/error/validation_error'

describe EmployeesController do

  context 'create' do

    it 'creates an employee and returns the json representation' do
      pc = PaymentClassification::Hourly.new(25, '50')
      emp = Employee::Employee.new(31, 'Jim', '123 Sweet St.', pc)
      Employee::AddEmployee.any_instance.should_receive(:execute).and_return(emp)
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
      Employee::AddEmployee.any_instance.should_receive(:execute).and_raise(ValidationError.new(errors))
      pc_hash = {'type' => 'hourly', 'rate' => '50'}
      emp_hash = {'name' => 'Jimmy', 'address' => 'The Louve', 'payment_classification' => pc_hash}
      post :create, :employee => emp_hash
      json_response = JSON.parse(response.body)
      json_response.should include('errors')
      json_response['errors'].should == errors
    end

    it 'handles nil input' do 
      errors = {'yo_mamma_said' => 'not enough cool aid'}
      Employee::AddEmployee.any_instance.should_receive(:execute).and_raise(ValidationError.new(errors))
      post :create
      json_response = JSON.parse(response.body)
      json_response.should include('errors')
      json_response['errors'].should == errors
    end

  end

  context 'delete' do
  
    it 'deletes an employee' do
    end

  end
end
