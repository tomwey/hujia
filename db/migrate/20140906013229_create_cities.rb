class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :province
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :cities, :province_id
  end
end
