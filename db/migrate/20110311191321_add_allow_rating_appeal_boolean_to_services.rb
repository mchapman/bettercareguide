class AddAllowRatingAppealBooleanToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :disable_rating_appeal, :datetime
    remove_column :ratings, :original_stars
    remove_column :ratings, :response_user
    add_column :ratings, :response_user_id, :integer
  end

  def self.down
    remove_column :services, :disable_rating_appeal
    add_column :ratings, :original_stars, :integer
    remove_column :ratings, :response_user_id
    add_column :ratings, :response_user, :integer
  end
end
