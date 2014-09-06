class AddProvinceAndCityToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :province, :string
    add_column :customers, :city, :string
  end
end
