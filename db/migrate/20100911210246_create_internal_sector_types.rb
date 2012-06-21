class CreateInternalSectorTypes < ActiveRecord::Migration
  def self.up
    create_table :internal_sector_types do |t|
      t.string :description, :null => false, :limit => 45

      t.timestamps
    end
  end

  def self.down
    drop_table :internal_sector_types
  end
end
