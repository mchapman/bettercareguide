class CreatePublicScoresStatuses < ActiveRecord::Migration
  def self.up
    create_table :public_scores_statuses do |t|
      t.string :description, :limit => 45
      t.boolean :visible

      t.timestamps
    end
  end

  def self.down
    drop_table :public_scores_statuses
  end
end
