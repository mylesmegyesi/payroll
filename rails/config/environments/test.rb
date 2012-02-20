require 'in_memory/transaction/factory'

Payroll::Application.configure do

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

end

TRANSACTION_FACTORY = Transaction::Factory.new
