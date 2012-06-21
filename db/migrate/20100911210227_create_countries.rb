class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name, :limit => 45
      t.string :dial_code, :limit => 45

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
