class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :screenshot
      t.string :summary
      t.string :title
      t.string :url
      t.integer :sort
      t.boolean :visible, :default => true

      t.timestamps
    end
    
  end
end
