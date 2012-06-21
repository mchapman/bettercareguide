class AddPoorQualityGeocodingFlag < ActiveRecord::Migration
  def self.up
    change_column :addresses, :line1, :string, :limit => 120, :null => false
    add_column :addresses, :geocoded_by_town, :boolean
  end

  def self.down
    change_column :addresses, :line1, :string, :limit => 50, :null => false
    remove_column :addresses, :geocoded_by_town
  end
end
