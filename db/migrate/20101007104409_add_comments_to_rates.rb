require 'migration_helpers'

class AddCommentsToRates < ActiveRecord::Migration
  def self.up
    execute(MigrationHelper.drop_foreign_key(:comments, :public_scores))
    execute(MigrationHelper.drop_foreign_key(:comments, :people))
    execute(MigrationHelper.drop_foreign_key(:public_scores, :services))
    execute(MigrationHelper.drop_foreign_key(:public_scores, :people))
#    execute(MigrationHelper.drop_foreign_key(:public_scores, :public_scores_status))
    remove_index :comments, :person_id
    remove_index :public_scores, :service_id
    remove_index :public_scores, :person_id

    drop_table :public_scores
    drop_table :comments


    add_column :rates, :comments, :text
    add_column :rates, :public_scores_status_id, :integer
    add_column :rates, :response_required_by, :datetime
    add_column :rates, :next_rating, :integer

    remove_index :rates, [:rateable_id, :rateable_type]
    remove_column :rates, :rateable_type
    remove_column :rates, :dimension
    add_index :rates, :rateable_id

    execute(MigrationHelper.foreign_key(:rates, :rateable_id, :services))
    execute(MigrationHelper.foreign_key(:rates, :rater_id, :users))

    create_table :dialogue do |t|
      t.belongs_to :rate, :null => false
      t.datetime :created_at
      t.string :ip_address, :null => false, :limit => 16   # support for ipv6 addresses
      t.belongs_to :user, :null => false
      t.boolean :appeal_for_arbitration
    end
  end

  def self.down
    drop_table :dialogue
    remove_column :rates, :comments
  end
end
