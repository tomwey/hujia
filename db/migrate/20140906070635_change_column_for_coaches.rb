class ChangeColumnForCoaches < ActiveRecord::Migration
  def up
    rename_column :coaches, :is_authroized, :is_authorized
  end

  def down
  end
end
