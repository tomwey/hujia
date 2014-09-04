class AddClaimedAtToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :claimed_at, :datetime
  end
end
