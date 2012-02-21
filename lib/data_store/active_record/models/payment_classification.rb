require 'active_record'

module DataStore
  module AR
    module Models
      class PaymentClassification < ActiveRecord::Base
        belongs_to :employee
      end
    end
  end
end
