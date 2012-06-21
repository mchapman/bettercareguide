class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :family_name, :null => false, :limit => 45
      t.string :given_name, :limit => 45
      t.string :middle_names, :limit => 45

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
