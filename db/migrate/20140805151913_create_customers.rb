class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :real_name
      t.string :mobile
      t.string :city
      t.string :location

      t.timestamps
    end
    add_index :customers, :mobile, :unique => true
  end
end
