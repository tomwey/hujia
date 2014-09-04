class AddCommentsCountTo < ActiveRecord::Migration
  def change
    add_column :schools, :comments_count, :integer, :default => 0
    add_column :coaches, :comments_count, :integer, :default => 0
  end
end
