module DataStore
  module AR
    module Employee
      class DeleteByID < Transaction

        def execute(id)
          emp = DataStore::AR::Models::Employee.find_by_id(id)
          if emp
            emp.destroy
          end
        end
      
      end
    end
  end
end