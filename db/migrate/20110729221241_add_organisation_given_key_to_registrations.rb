class AddOrganisationGivenKeyToRegistrations < ActiveRecord::Migration
  def self.up
    change_column :registrations, :regulator_given_id, :string, :limit => 15
    change_column :regulators, :web_page_format, :string, :limit => 255
  end

  def self.down
    change_column :registrations, :regulator_given_id, :string, :limit => 255
    change_column :regulators, :web_page_format, :string, :limit => 120
  end
end
