require 'data_store/in_memory/transaction_factory'

TRANSACTION_FACTORY = DataStore::InMemory::TransactionFactory.new

Payroll::Application.configure do

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

end

