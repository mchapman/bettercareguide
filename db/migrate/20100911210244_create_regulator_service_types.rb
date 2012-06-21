class CreateRegulatorServiceTypes < ActiveRecord::Migration
  def self.up
    create_table :regulator_service_types do |t|
      t.string :regulator_description, :null => false, :limit => 120

      t.integer :internal_service_type_id
      t.integer :regulator_id
      t.timestamps
    end
  end

  def self.down
    drop_table :regulator_service_types
  end
end
