require 'active_record'
require 'data_store/active_record/models/payment_classification'

module DataStore
  module AR
    module Models
      class Employee < ActiveRecord::Base
        has_one :payment_classification
        accepts_nested_attributes_for :payment_classification
      end
    end
  end
end
