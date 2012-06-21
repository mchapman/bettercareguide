class ChangeCachedRatingType < ActiveRecord::Migration
  def self.up
    change_column :services, :cached_rating, :integer
  end

  def self.down
    change_column :services, :cached_rating, :float
  end
end
