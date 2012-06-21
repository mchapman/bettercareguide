class ExtendFieldLengthOnService < ActiveRecord::Migration
  def self.up
    change_column :regulator_service_types, :regulator_description, :string, :null => false
  end

  def self.down
    change_column :regulator_service_types, :regulator_description, :string, :limit => 120, :null => false
  end
end
