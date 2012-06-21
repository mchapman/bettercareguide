class RejigPublicScoresStatus < ActiveRecord::Migration
  def self.up
    remove_column :rates, :public_scores_status_id
    add_column :rates, :status_mask, :integer
  end

  def self.down
  end
end
