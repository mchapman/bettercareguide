class CreateRegulatorSectorTypes < ActiveRecord::Migration
  def self.up
    create_table :regulator_sector_types do |t|
      t.string :regulator_description, :null => false, :limit => 120

      t.integer :regulator_id
      t.integer :internal_sector_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :regulator_sector_types
  end
end
