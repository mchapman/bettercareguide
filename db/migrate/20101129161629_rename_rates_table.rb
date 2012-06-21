class RenameRatesTable < ActiveRecord::Migration
  def self.up
    rename_table :rates, :ratings
    rename_column :ratings, :rateable_id, :service_id
  end

  def self.down
    rename_column :ratings, :service_id, :rateable_id
    rename_table :ratings, :rates
  end
end
