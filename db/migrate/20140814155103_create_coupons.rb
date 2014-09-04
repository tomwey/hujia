class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :image
      t.string :value
      t.boolean :verified, :default => true
      t.integer :ownerable_id
      t.string :ownerable_type
      t.integer :user_id

      t.timestamps
    end
    
    add_index :coupons, :ownerable_id
    add_index :coupons, :ownerable_type
    add_index :coupons, :user_id
  end
end
