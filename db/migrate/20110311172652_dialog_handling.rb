require 'migration_helpers'

class DialogHandling < ActiveRecord::Migration
  def self.up
    drop_table :dialogues

    add_column :ratings, :response_text, :text
    add_column :ratings, :response_ip_address, :string, :limit => 16
    add_column :ratings, :response_user, :integer
    add_column :ratings, :response_datetime, :datetime
  end

  def self.down
    remove_column :ratings, :response_text
    remove_column :ratings, :response_ip_address
    remove_column :ratings, :response_user
    remove_column :ratings, :response_datetime
  end
end
