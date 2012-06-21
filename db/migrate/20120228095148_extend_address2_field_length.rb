class ExtendAddress2FieldLength < ActiveRecord::Migration
  def self.up
    change_column :addresses, :line2, :string, :limit => 120
  end

  def self.down
    change_column :addresses, :line2, :string, :limit => 45
  end
end