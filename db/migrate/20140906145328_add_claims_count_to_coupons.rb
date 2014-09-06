class AddClaimsCountToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :claims_count, :integer, :default => 0
  end
end
