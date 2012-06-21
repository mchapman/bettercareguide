class AddLongDescriptionToRaterType < ActiveRecord::Migration
  def self.up
    rename_column(:rater_types, :description, :short_description)
    add_column(:rater_types, :long_description, :string, { :limit => 60})
  end

  def self.down
    rename_column(:rater_types, :short_description, :description)
    remove_column(:rater_types, :long_description)
  end
end
