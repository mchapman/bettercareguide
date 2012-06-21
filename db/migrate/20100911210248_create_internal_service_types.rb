class CreateInternalServiceTypes < ActiveRecord::Migration
  def self.up
    create_table :internal_service_types do |t|
      t.string :description, :null => false, :limit => 45
      t.boolean :requires_type_col
      t.integer :sort_order

      t.timestamps
    end
  end

  def self.down
    drop_table :internal_service_types
  end
end
