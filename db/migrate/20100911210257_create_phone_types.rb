class CreatePhoneTypes < ActiveRecord::Migration
  def self.up
    create_table :phone_types do |t|
      t.string :description, :null => false, :limit => 45

      t.timestamps
    end
  end

  def self.down
    drop_table :phone_types
  end
end
