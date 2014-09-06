class AddTitleAndSubtitleToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :title, :string
    add_column :coupons, :subtitle, :string
  end
end
