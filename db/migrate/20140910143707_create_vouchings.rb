class CreateVouchings < ActiveRecord::Migration
  def change
    create_table :vouchings do |t|
      t.integer :user_id
      t.integer :coupon_id

      t.timestamps
    end
    
    add_index :vouchings, :user_id
    add_index :vouchings, :coupon_id
    
  end
end
