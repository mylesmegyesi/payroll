require 'in_memory/transaction/base'

module Transaction

  class CreateEmployee < Base

    def execute(employee)
      emp_id = self.class.get_id(:employee)
      employee.id = emp_id
      pc_id = self.class.get_id(:payment_classification)
      employee.payment_classification.id = pc_id
      self.class.add(:employee, employee)
    end

  end

end
