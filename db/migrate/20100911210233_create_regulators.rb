class CreateRegulators < ActiveRecord::Migration
  def self.up
    create_table :regulators do |t|
      t.string :domain, :null => false, :limit => 100
      t.string :web_page_format, :limit => 120

      t.integer :organisation_id
      t.timestamps
    end
  end

  def self.down
    drop_table :regulators
  end
end
