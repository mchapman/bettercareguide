class CreateEmployments < ActiveRecord::Migration
  def self.up
    create_table :employments do |t|
      t.date :start_date
      t.date :end_date

      t.integer :organisation_id
      t.integer :person_id
      t.timestamps
    end
  end

  def self.down
    drop_table :employments
  end
end
