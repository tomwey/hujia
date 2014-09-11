class AddIsShowUserInfoToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_show_user_info, :boolean, default: true
  end
end
