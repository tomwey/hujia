class AddIndexes < ActiveRecord::Migration
  def up
    add_index :users, :profile_id
    add_index :users, :profile_type
  end

  def down
    remove_index :users, :profile_id
    remove_index :users, :profile_type
  end
end
