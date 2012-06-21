class TandCAgain < ActiveRecord::Migration
  def self.up
    add_column :users, :terms_and_conditions, :datetime
    User.update_all ["terms_and_conditions = ?", Time.now]
  end

  def self.down
    remove_column :users, :terms_and_conditions
  end
end
