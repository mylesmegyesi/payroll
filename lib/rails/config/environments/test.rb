require 'data_store/in_memory/transaction_factory'

Core::Application.configure do

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

end

TRANSACTION_FACTORY = DataStore::InMemory::TransactionFactory.new
