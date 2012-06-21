class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :number, :limit => 15
      t.integer :country_id, :null => false
      t.integer :phone_type_id
      t.integer :address_type_id, :null => false
      t.integer :organisation_id
      t.integer :person_id
      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
