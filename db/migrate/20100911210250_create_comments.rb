class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.float :rating, :null => false
      t.text :comment_text
      t.string :ip_address, :null => false, :limit => 15
      t.datetime :when, :null => false

      t.integer :public_score_id
      t.integer :person_id
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
