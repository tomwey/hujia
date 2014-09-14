class CreateRatingScores < ActiveRecord::Migration
  def change
    create_table :rating_scores do |t|
      t.integer :user_id
      t.float :score
      t.integer :comment_id

      t.timestamps
    end
    
    add_index :rating_scores, :user_id
    add_index :rating_scores, :comment_id
  end
end
