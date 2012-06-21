class AddDeregistrationDateToService < ActiveRecord::Migration
  def self.up
    add_column :services, :deregistration_date, :datetime
    change_column :organisations, :name, :string, :limit => 120, :null => false
  end

  def self.down
    remove_column :services, :deregistration_date
    change_column :organisations, :name, :string, :limit => 60, :null => false
  end
end
