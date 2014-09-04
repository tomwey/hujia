class AddCoachIdAndServiceAreaIdToCoachesServiceAreas < ActiveRecord::Migration
  def change
    create_table :coaches_service_areas, :id =>false do |t|
      t.integer :coach_id
      t.integer :service_area_id
    end
    
    add_index :coaches_service_areas, [:coach_id, :service_area_id]
  end
end
