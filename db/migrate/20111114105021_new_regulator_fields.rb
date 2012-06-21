class NewRegulatorFields < ActiveRecord::Migration
  def self.up
    add_column :regulators, :description, :string
    add_column :regulators, :short_name, :string, {:limit => 10 }
    add_column :regulators, :last_scrape_start, :datetime
    add_column :regulators, :last_scrape_finish, :datetime
    add_column :regulators, :last_complete_scrape, :datetime
    add_column :regulators, :scraper, :string,  { :limit => 50 }
    add_column :regulators, :obsolete, :boolean
  end

  def self.down
    remove_column :regulators, :description
    remove_column :regulators, :short_name
    remove_column :regulators, :last_scrape_start
    remove_column :regulators, :last_scrape_finish
    remove_column :regulators, :last_complete_scrape
    remove_column :regulators, :scraper
    remove_column :regulators, :obsolete
  end
end
