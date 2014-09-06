class AddIsCheckToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :is_authroized, :boolean, :default => false
  end
end
