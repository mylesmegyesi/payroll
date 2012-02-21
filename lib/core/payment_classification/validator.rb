require 'active_model'

module Core
  module PaymentClassification
    module Validator

      def self.validate(pc)
        pc ||= {}
        am_pc = ActiveModelPC.new(pc[:classification], pc[:rate], pc[:salary])
        am_pc.valid?
        am_pc.errors.to_hash
      end

      private

      class ActiveModelPC
        include ActiveModel::Validations
        attr_reader :classification, :rate, :salary

        validates :classification, :inclusion => {:in => ['hourly', 'salary', 'commission']}
        validates :rate, :presence => true, :numericality => true, :if => :hourly?
        validates :salary, :presence => true, :numericality => true, :if => :salaried?

        def initialize(classification, rate, salary)
          @classification = classification
          @rate = rate
          @salary = salary
        end

        private 

        def hourly?
          @classification == 'hourly' || @classification == 'commission'
        end

        def salaried?
          @classification == 'salary' || @classification == 'commission'
        end
      end
    end
  end
end
