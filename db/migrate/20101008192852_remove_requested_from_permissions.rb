class RemoveRequestedFromPermissions < ActiveRecord::Migration
  def self.up
    remove_column :permissions, :requested
    add_column :permissions, :code_failures, :integer
  end

  def self.down
    add_column :permissions, :requested, :datetime
  end
end
