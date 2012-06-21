class CreateRegulatorScores < ActiveRecord::Migration
  def self.up
    create_table :regulator_scores do |t|
      t.string :regulator_description, :null => false, :limit => 255

      t.integer :internal_regulator_score_id
      t.integer :regulator_id
      t.timestamps
    end
  end

  def self.down
    drop_table :regulator_scores
  end
end
