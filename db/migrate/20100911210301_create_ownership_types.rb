class CreateOwnershipTypes < ActiveRecord::Migration
  def self.up
    create_table :ownership_types do |t|
      t.string :description, :null => false, :limit => 45

      t.timestamps
    end
  end

  def self.down
    drop_table :ownership_types
  end
end
