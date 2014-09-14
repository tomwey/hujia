class AddVisibleToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :visible, :boolean, :default => true
  end
end
