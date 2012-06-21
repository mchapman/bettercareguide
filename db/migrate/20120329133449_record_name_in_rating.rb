class RecordNameInRating < ActiveRecord::Migration
  def up
    add_column :ratings, :name_recording_url, :string
  end

  def down
    remove_column :ratings, :name_recording_url
  end
end
