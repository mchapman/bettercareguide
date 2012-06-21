class EnhancePermissions < ActiveRecord::Migration
  def self.up
    add_column :services, :invite_comment_up_to_stars, :integer
    add_column :services, :users_need_approval, :boolean

    add_column :permissions, :email_all_ratings, :boolean
    add_column :permissions, :notify_poor_ratings, :boolean
    add_column :permissions, :obsolete, :boolean
  end

  def self.down
    remove_column :services, :invite_comment_up_to_stars
    remove_column :services, :users_need_approval

    remove_column :permissions, :email_all_ratings
    remove_column :permissions, :notify_poor_ratings
    remove_column :permissions, :obsolete
  end
end
