class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :regulator_service_ref, :limit => 15
      t.date :registration_date, :null => false
      t.boolean :registration_date_implied
      t.integer :capacity
      t.text :description
      t.string :elevator_pitch, :limit => 100

      t.integer :regulator_service_type_id
      t.integer :regulator_sector_type_id
      t.integer :regulator_id
      t.integer :organisation_id
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
