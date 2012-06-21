class CreateOwnerships < ActiveRecord::Migration
  def self.up
    create_table :ownerships do |t|
      t.date :start_date
      t.date :end_date
      t.float :share
      t.integer :owning_organisation_id
      t.integer :organisation_id
      t.integer :person_id
      t.integer :ownership_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ownerships
  end
end
