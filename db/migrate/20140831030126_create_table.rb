class CreateTable < ActiveRecord::Migration
  def change
    create_table :coaches_colleges, :id =>false do |t|
      t.integer :coach_id
      t.integer :college_id
    end
    
    add_index :coaches_colleges, [:coach_id, :college_id]
  end
end
