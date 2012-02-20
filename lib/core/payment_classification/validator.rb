require 'active_model'

module Core
  module PaymentClassification
    module Validator

      def self.validate(pc)
        pc ||= {}
        am_pc = ActiveModelPC.new(pc[:type], pc[:rate], pc[:salary])
        am_pc.valid?
        am_pc.errors.to_hash
      end

      private

      class ActiveModelPC
        include ActiveModel::Validations
        attr_reader :type, :rate, :salary

        validates :type, :inclusion => {:in => ['hourly', 'salary', 'commission']}
        validates :rate, :presence => true, :numericality => true, :if => :hourly?
        validates :salary, :presence => true, :numericality => true, :if => :salaried?

        def initialize(type, rate, salary)
          @type = type
          @rate = rate
          @salary = salary
        end

        private 

        def hourly?
          @type == 'hourly' || @type == 'commission'
        end

        def salaried?
          @type == 'salary' || @type == 'commission'
        end
      end
    end
  end
end
