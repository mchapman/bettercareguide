class AddRejectedToPermissions < ActiveRecord::Migration
  def self.up
    add_column :permissions, :requested, :datetime
    add_column :permissions, :notes, :text
    add_column :permissions, :processed, :datetime
    add_column :permissions, :accepted, :boolean
    add_column :permissions, :processed_by_id, :integer
  end

  def self.down
    remove_column :permissions, :requested
    remove_column :permissions, :notes
    remove_column :permissions, :processed
    remove_column :permissions, :accepted
    remove_column :permissions, :processed_by_id
  end
end
