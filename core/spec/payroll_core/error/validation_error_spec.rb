require 'payroll_core/error/validation_error'

describe ValidationError do

  it 'sets the errors' do
    errors = {:thing1 => 'hello!', :thing2 => 'bye, bye!'}
    ve = ValidationError.new(errors)
    ve.errors.should == errors
  end

end
