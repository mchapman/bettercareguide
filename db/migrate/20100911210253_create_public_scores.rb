class CreatePublicScores < ActiveRecord::Migration
  def self.up
    create_table :public_scores do |t|

      t.integer :service_id
      t.integer :person_id
      t.integer :public_scores_status_id
      t.timestamps
    end
  end

  def self.down
    drop_table :public_scores
  end
end
