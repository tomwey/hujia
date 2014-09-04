class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :company
      t.string :real_name
      t.integer :sex, :default => 0
      t.string :mobile, :null => false
      t.string :qq
      t.string :city
      t.string :location
      t.string :pickup_location
      t.string :intro
      t.string :service_type
      t.string :image

      t.timestamps
    end
    
    add_index :coaches, :mobile, :unique => true
    add_index :coaches, :qq, :unique => true
  end
end
