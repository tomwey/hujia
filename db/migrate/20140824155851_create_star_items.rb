class CreateStarItems < ActiveRecord::Migration
  def change
    create_table :star_items do |t|
      t.string :name
      t.string :summary
      t.integer :score, :default => 0
      t.integer :comment_id

      t.timestamps
    end
    add_index :star_items, :comment_id
  end
end
