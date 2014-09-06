class AddIndexesForCitiesAndProvinces < ActiveRecord::Migration
  def up
    add_index :provinces, :code, :unique => true
    add_index :cities, :code, :unique => true
  end

  def down
    remove_index :provinces, :code
    remove_index :cities, :code
  end
end
