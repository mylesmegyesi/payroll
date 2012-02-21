require 'data_store/active_record/spec_helper'
require 'data_store/active_record/employee/delete_by_id'

describe DataStore::AR::Employee::DeleteByID do

  after :each do
    DataStore::AR::Models::Employee.destroy_all
  end

  it 'deletes the employee from the database' do
    emp = DataStore::AR::Models::Employee.create!(:name => 'blah', :address => 'thing')
    del = DataStore::AR::Employee::DeleteByID.new
    del.execute(emp.id)
    DataStore::AR::Models::Employee.count.should == 0
  end

end