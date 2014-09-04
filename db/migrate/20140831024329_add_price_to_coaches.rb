class AddPriceToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :price, :integer
  end
end
