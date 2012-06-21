class IndexAddressesByPostcode < ActiveRecord::Migration
  def self.up
    add_index :addresses, :postal_zip_code
    change_column :registrations, :regulator_given_id, :string, :limit => 120
  end

  def self.down
    remove_index :addresses, :postal_zip_code
    change_column :registrations, :regulator_given_id, :string, :limit => 15
  end
end
