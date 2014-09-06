class AddCityToColleges < ActiveRecord::Migration
  def change
    add_column :colleges, :city_id, :integer
    add_index  :colleges, :city_id
  end
end
