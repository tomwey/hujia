class AddPriceToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :price, :integer
  end
end
