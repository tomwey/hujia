class ChangeFieldsForCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :value
    remove_column :coupons, :verified
    
    add_column :coupons, :value, :integer, :default => 300
    add_column :coupons, :verified, :boolean, :default => false
    add_column :coupons, :start_date, :date
    add_column :coupons, :end_date, :date
    add_column :coupons, :publish_count, :integer, :default => 100 # 发行数量
    add_column :coupons, :actives_count, :integer, :default => 0
  end
end
