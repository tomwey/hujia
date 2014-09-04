class AddFieldsToSchoolsAndCoaches < ActiveRecord::Migration
  def change
    add_column :schools, :star_count, :integer, :default => 3
    add_column :coaches, :star_count, :integer, :default => 3
    
    add_column :schools, :sort, :integer
    add_column :coaches, :sort, :integer
    
    add_index :schools, :sort
    add_index :coaches, :sort
  end
end
