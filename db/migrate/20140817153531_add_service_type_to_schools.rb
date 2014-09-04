class AddServiceTypeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :service_type, :string
  end
end
