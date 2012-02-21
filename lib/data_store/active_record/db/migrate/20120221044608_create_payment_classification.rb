class CreatePaymentClassification < ActiveRecord::Migration
  def up
    create_table :payment_classifications do |t|
      t.string :employee_id
      t.string :rate
      t.string :salary
      t.string :classification
      t.timestamps
    end
  end

  def down
  end
end
