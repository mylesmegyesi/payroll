require 'payroll/error/validation_error'

describe Payroll::Error::ValidationError do

  it 'sets the errors' do
    errors = {:thing1 => 'hello!', :thing2 => 'bye, bye!'}
    ve = Payroll::Error::ValidationError.new(errors)
    ve.errors.should == errors
  end

end
