class AddProvinceToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :province, :string
  end
end
