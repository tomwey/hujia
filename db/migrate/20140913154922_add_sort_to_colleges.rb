class AddSortToColleges < ActiveRecord::Migration
  def change
    add_column :colleges, :sort, :integer, :default => 0
  end
end
