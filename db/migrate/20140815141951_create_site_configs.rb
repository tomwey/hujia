class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
    add_index :site_configs, :key, :unique => true
  end
end
