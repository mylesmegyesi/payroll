require 'payroll_core/payment_classification/hourly'
require 'payroll_core/payment_classification/salary'
require 'payroll_core/payment_classification/commission'

module PaymentClassification
  class Factory

    def self.create(pc)
      case pc[:type]
      when 'hourly'
        Hourly.new(pc[:id], pc[:rate])
      when 'salary'
        Salary.new(pc[:id], pc[:salary])
      when 'commission'
        Commission.new(pc[:id], pc[:salary], pc[:rate])
      end
    end

  end
end
