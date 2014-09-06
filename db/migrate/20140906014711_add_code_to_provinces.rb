class AddCodeToProvinces < ActiveRecord::Migration
  def change
    add_column :provinces, :code, :string
  end
end
