class AddAccessCodeToPermissions < ActiveRecord::Migration
  def self.up
    add_column :permissions, :access_code, :integer
  end

  def self.down
    remove_column :permissions, :access_code
  end
end
