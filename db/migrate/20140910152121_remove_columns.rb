class RemoveColumns < ActiveRecord::Migration
  def change
    remove_index :coupons, :user_id
    remove_column :coupons, :user_id
    remove_column :coupons, :claimed_at
  end
  
end
