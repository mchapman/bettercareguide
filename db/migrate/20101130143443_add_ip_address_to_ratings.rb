class AddIpAddressToRatings < ActiveRecord::Migration
  def self.up
    add_column :ratings, :creation_ip_address, :string, {:default => 'fill', :limit => 16, :null => false }
  end

  def self.down
    remove_column :ratings, :creation_ip_address
  end
end
