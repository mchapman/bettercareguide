class AddOriginalStarsToRate < ActiveRecord::Migration
  def self.up
    add_column :rates, :original_stars, :integer
    add_column :rates, :rater_type_id, :integer

    create_table :rater_types do |t|
      t.string :description, :limit => 35, :null => false
      t.timestamps
    end
  end

  def self.down
    remove_column :rates, :original_stars
    remove_column :rates, :rater_type_id
    drop_table :rater_types
  end
end
