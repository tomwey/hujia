class AddStatusToVouchings < ActiveRecord::Migration
  def change
    add_column :vouchings, :status, :integer, default: 0 # 0表示 已领取，1表示已验证，2表示已评价
  end
end
