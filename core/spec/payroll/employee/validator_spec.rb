require 'payroll/employee/validator'

describe Payroll::Employee::Validator do
  
  let(:valid_employee) {
    {
      :name => 'Jim Bob',
      :address => '123 sweet St',
    }
  }

  it 'returns no errors for a valid employee' do
    Payroll::Employee::Validator.validate(valid_employee).should be_empty
  end

  context 'name' do

    it 'returns an error when name is not present' do
      valid_employee[:name] = nil 
      errors = Payroll::Employee::Validator.validate(valid_employee)
      errors.should include(:name)
    end

    it 'returns an error when name is an empty string' do
      valid_employee[:name] = '' 
      errors = Payroll::Employee::Validator.validate(valid_employee)
      errors.should include(:name)
    end

  end

  context 'address' do
  
    it 'returns an error when address is not present' do
      valid_employee[:address] = nil 
      errors = Payroll::Employee::Validator.validate(valid_employee)
      errors.should include(:address)
    end

    it 'returns an error when name is an empty string' do
      valid_employee[:address] = '' 
      errors = Payroll::Employee::Validator.validate(valid_employee)
      errors.should include(:address)
    end
  
  end
  
end
