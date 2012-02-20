ENV["RAILS_ENV"] ||= 'test'
require 'rails/config/environment'
require 'rspec/rails'
require 'rspec/rails/example/controller_example_group'

RSpec::configure do |c|
  def c.escaped_path(*parts)
    Regexp.compile(parts.join('[\\\/]'))
  end

  c.include RSpec::Rails::ControllerExampleGroup, :type => :controller, :example_group => {
    :file_path => c.escaped_path(%w[spec rails controllers])
  }
end
