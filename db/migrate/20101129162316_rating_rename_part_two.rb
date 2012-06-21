class RatingRenamePartTwo < ActiveRecord::Migration
  def self.up
    rename_column :dialogues, :rate_id, :rating_id
    puts "Now modify rates.db model where it creates the Dialogue"
  end

  def self.down
    rename_column :dialogues, :rating_id, :rate_id
  end
end
