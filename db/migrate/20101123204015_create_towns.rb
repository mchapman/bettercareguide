class CreateTowns < ActiveRecord::Migration
  def self.up
    create_table :towns do |t|
      t.string :name, :null => false, :limit => 60
      t.float :lat, :null => false
      t.float :lng, :null => false

      t.timestamps
    end

    add_index :towns, :name, {:unique => true}
  end

  def self.down
    drop_table :towns
  end
end
