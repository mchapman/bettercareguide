class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :line1, :null => false, :limit => 50
      t.string :line2, :limit => 45
      t.string :line3, :limit => 45
      t.string :city, :null => false, :limit => 35
      t.string :state, :limit => 30
      t.string :postal_zip_code, :limit => 12
      t.integer :address_type_id, :null => false
      t.integer :organisation_id
      t.integer :person_id
      t.float :lat
      t.float :lng

      t.integer :country_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
