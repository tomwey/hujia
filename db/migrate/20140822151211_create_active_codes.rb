class CreateActiveCodes < ActiveRecord::Migration
  def change
    create_table :active_codes do |t|
      t.string :code
      t.datetime :actived_at
      t.boolean :verified, :default => true
      t.integer :user_id
      t.integer :coupon_id

      t.timestamps
    end
    add_index :active_codes, :code, :unique => true
    add_index :active_codes, :user_id
    add_index :active_codes, :coupon_id
  end
end
