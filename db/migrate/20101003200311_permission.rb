class Permission < ActiveRecord::Migration
  def self.up
    create_table(:permissions) do |t|
      t.integer :organisation_id
      t.integer :service_id
      t.integer :user_id, :null => false
      t.boolean :is_owner

      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
