class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.references :photoable, :polymorphic => true

      t.timestamps
    end
    add_index :photos, :photoable_id
    add_index :photos, :photoable_type
  end
end
