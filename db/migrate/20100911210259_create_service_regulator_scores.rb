class CreateServiceRegulatorScores < ActiveRecord::Migration
  def self.up
    create_table :service_regulator_scores do |t|
      t.date :effective_date, :null => false

      t.integer :regulator_score_id
      t.integer :service_id
      t.timestamps
    end
  end

  def self.down
    drop_table :service_regulator_scores
  end
end
