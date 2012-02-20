require 'core/error/validation_error'

describe Core::Error::ValidationError do

  it 'sets the errors' do
    errors = {:thing1 => 'hello!', :thing2 => 'bye, bye!'}
    ve = Core::Error::ValidationError.new(errors)
    ve.errors.should == errors
  end

end
