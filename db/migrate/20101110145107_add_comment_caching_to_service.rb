class AddCommentCachingToService < ActiveRecord::Migration
  def self.up
    add_column :services, :cached_rating, :float
    add_column :services, :no_comments, :integer
  end

  def self.down
    remove_column :services, :cached_rating
    remove_column :services, :no_comments
  end
end
