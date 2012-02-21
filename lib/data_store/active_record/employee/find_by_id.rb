require 'data_store/active_record/transaction'
require 'data_store/active_record/models/employee'
require 'data_store/active_record/models/payment_classification'
require 'core/employee/employee'
require 'core/payment_classification/factory'

module DataStore
  module AR
    module Employee
      class FindByID < Transaction

        def execute(id)
          ar_emp = DataStore::AR::Models::Employee.find_by_id(id)
          unless ar_emp.nil?
            ar_pc = ar_emp.payment_classification || DataStore::AR::Models::PaymentClassification.new
            pc_hash = {:id => ar_pc.id, :classification => ar_pc.classification, :rate => ar_pc.rate, :salary => ar_pc.salary}
            pc = Core::PaymentClassification::Factory.create(pc_hash)
            Core::Employee::Employee.new(ar_emp.id, ar_emp.name, ar_emp.address, pc)
          end
        end
      
      end
    end
  end
end