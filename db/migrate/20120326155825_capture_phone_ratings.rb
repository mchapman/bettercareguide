class CapturePhoneRatings < ActiveRecord::Migration
  def up
    add_column :ratings, :phone, :string, :limit => 15
    add_column :ratings, :ivr_session, :string
    add_column :ratings, :recording_url, :string
    add_index :ratings, :ivr_session, :unique
  end

  def down
    remove_index :ratings, :ivr_session
    remove_column :ratings, :phone
    remove_column :ratings, :recording_url
    remove_column :ratings, :ivr_session
  end
end
