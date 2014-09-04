class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :private_token, :string
    add_column :users, :verified, :boolean, :default => true
    
    add_index :users, :nickname, :unique => true
    add_index :users, :private_token, :unique => true
  end
end
