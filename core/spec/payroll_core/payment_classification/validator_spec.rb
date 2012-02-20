require 'payroll_core/payment_classification/validator'

describe PaymentClassification::Validator do

  context 'hourly' do

    it 'returns an error if rate is not present' do    
      errors = PaymentClassification::Validator.validate({:type => 'hourly'})
      errors.should include(:rate)
    end

    it 'returns an error if rate is not numeric' do
      errors = PaymentClassification::Validator.validate({:type => 'hourly', :rate => 'word'})
      errors.should include(:rate)
    end

    it 'returns no errors if rate is a number' do
      errors = PaymentClassification::Validator.validate({:type => 'hourly', :rate => '100'})
      errors.should be_empty
    end

  end

  context 'salary' do
    
    it 'returns an error if salary is not present' do
      errors = PaymentClassification::Validator.validate({:type => 'salary'})
      errors.should include(:salary)
    end
 
    it 'returns an error if salary is not numeric' do
      errors = PaymentClassification::Validator.validate({:type => 'salary', :salary => 'word'})
      errors.should include(:salary)
    end
    
    it 'returns no errors if salary is a number' do
      errors = PaymentClassification::Validator.validate({:type => 'salary', :salary => '100'})
      errors.should be_empty
    end
  end

  context 'commission' do
    
    it 'returns an error if salary is not present' do
      errors = PaymentClassification::Validator.validate({:type => 'commission'})
      errors.should include(:salary)
    end
 
    it 'returns an error if salary is not numeric' do
      errors = PaymentClassification::Validator.validate({:type => 'commission', :salary => 'word'})
      errors.should include(:salary)
    end


    it 'returns an error if rate is not present' do
      errors = PaymentClassification::Validator.validate({:type => 'commission'})
      errors.should include(:salary)
    end
 
    it 'returns an error if rate is not numeric' do
      errors = PaymentClassification::Validator.validate({:type => 'commission', :rate => 'word'})
      errors.should include(:rate)
    end

    it 'returns no errors if rate and salary are numbers' do
      errors = PaymentClassification::Validator.validate({:type => 'commission', :rate => '10', :salary => '10'})
      errors.should be_empty
    end
  
  end

  it 'returns an error when type is invalid' do
    PaymentClassification::Validator.validate({:type => ''}).should include(:type)
  end
   
end
