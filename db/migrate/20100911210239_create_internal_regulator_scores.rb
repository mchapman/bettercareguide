class CreateInternalRegulatorScores < ActiveRecord::Migration
  def self.up
    create_table :internal_regulator_scores do |t|
      t.string :description, :null => false, :limit => 45
      t.float :value, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :internal_regulator_scores
  end
end
