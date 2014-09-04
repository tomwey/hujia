class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :city
      t.string :location
      t.string :zcode
      t.string :name, :null => false
      t.string :linkman, :null => false
      t.string :phone
      t.string :mobile, :null => false
      t.string :website
      t.string :qq
      t.string :intro
      t.string :image

      t.timestamps
    end
    
    add_index :schools, :mobile, :unique => true
    add_index :schools, :qq, :unique => true
    add_index :schools, :phone, :unique => true
  end
end
