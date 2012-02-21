class CreateEmployees < ActiveRecord::Migration
  def up
    create_table :employees do |t|
      t.string :name
      t.string :address
      t.timestamps
    end
  end

  def down
    drop_table :employees
  end
end
