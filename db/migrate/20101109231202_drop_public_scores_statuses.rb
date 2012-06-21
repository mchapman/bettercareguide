class DropPublicScoresStatuses < ActiveRecord::Migration
  def self.up
    drop_table :public_scores_statuses
  end

  def self.down
  end
end
