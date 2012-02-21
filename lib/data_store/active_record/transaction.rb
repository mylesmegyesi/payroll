require 'active_record'

module DataStore
  module AR
    class Transaction
    
      def initialize
        self.class.ensure_connection_established
      end

      def self.ensure_connection_established
        if !ActiveRecord::Base.connected?
          db_config = self.load_db_config
          env_config = self.load_env_config(db_config)
          self.add_full_path(env_config)
          ActiveRecord::Base.establish_connection(env_config)
        end
      end

      private 
      
      def self.load_db_config
        db_config = YAML.load(File.read(File.join(File.dirname(__FILE__), 'config','database.yml')))
        if !db_config
          raise 'Database configuration not specified in data_store/active_record/config/database.yml'
        end
        db_config
      end

      def self.load_env_config(db_config)
        env = ENV['ENV'] ? ENV['ENV'] : 'development'
        db_config[env]
      end

      def self.add_full_path(config)
        if config['adapter'] == 'sqlite3'
          config['database'] = File.join(File.dirname(__FILE__), config['database'])
        end
      end
    
    end
  end
end
