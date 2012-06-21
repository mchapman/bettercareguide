require 'migration_helpers'

class ServiceLinks < ActiveRecord::Migration
  def self.up

    create_table :service_links do |t|
      t.string :url, :null => false
      t.integer :service_id, :null => false
      t.integer :user_id, :null => false
      t.date :publication_date
      t.timestamps
    end

    add_index :service_links, :service_id
    execute(MigrationHelper.foreign_key(:service_links, :service_id, :services))
    execute(MigrationHelper.foreign_key(:service_links, :user_id, :users))
  end

  def self.down
    drop_table :service_links
  end
end
