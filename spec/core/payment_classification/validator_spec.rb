require 'core/payment_classification/validator'

describe Core::PaymentClassification::Validator do

  context 'hourly' do

    it 'returns an error if rate is not present' do    
      errors = Core::PaymentClassification::Validator.validate({:classification => 'hourly'})
      errors.should include(:rate)
    end

    it 'returns an error if rate is not numeric' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'hourly', :rate => 'word'})
      errors.should include(:rate)
    end

    it 'returns no errors if rate is a number' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'hourly', :rate => '100'})
      errors.should be_empty
    end

  end

  context 'salary' do
    
    it 'returns an error if salary is not present' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'salary'})
      errors.should include(:salary)
    end
 
    it 'returns an error if salary is not numeric' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'salary', :salary => 'word'})
      errors.should include(:salary)
    end
    
    it 'returns no errors if salary is a number' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'salary', :salary => '100'})
      errors.should be_empty
    end
  end

  context 'commission' do
    
    it 'returns an error if salary is not present' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'commission'})
      errors.should include(:salary)
    end
 
    it 'returns an error if salary is not numeric' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'commission', :salary => 'word'})
      errors.should include(:salary)
    end


    it 'returns an error if rate is not present' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'commission'})
      errors.should include(:salary)
    end
 
    it 'returns an error if rate is not numeric' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'commission', :rate => 'word'})
      errors.should include(:rate)
    end

    it 'returns no errors if rate and salary are numbers' do
      errors = Core::PaymentClassification::Validator.validate({:classification => 'commission', :rate => '10', :salary => '10'})
      errors.should be_empty
    end
  
  end

  it 'returns an error when type is invalid' do
    Core::PaymentClassification::Validator.validate({:classification => ''}).should include(:classification)
  end
   
end
