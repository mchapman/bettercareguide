require 'migration_helpers'

class AddUserIdIntegerToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :user_id, :integer
    execute(MigrationHelper.foreign_key(:people, :user_id, :users))
    execute(MigrationHelper.foreign_key(:ratings, :response_user_id, :users))
  end

  def self.down
    remove_column :people, :user_id
  end
end
