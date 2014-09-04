class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :user
      t.references :appointable, :polymorphic => true

      t.timestamps
    end
    add_index :appointments, :user_id
    add_index :appointments, :appointable_id
    add_index :appointments, :appointable_type
  end
end
