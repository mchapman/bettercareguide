require 'migration_helpers'

class IndexesAndConstraints < ActiveRecord::Migration
  
  def self.up
    # indexes
    add_index :addresses, :organisation_id
    add_index :addresses, :person_id
    add_index :ownerships, :organisation_id
    add_index :ownerships, :owning_organisation_id
    add_index :ownerships, :person_id
    add_index :employments, :organisation_id
    add_index :employments, :person_id
    add_index :phones, :organisation_id
    add_index :phones, :person_id
    add_index :services, :organisation_id
    add_index :comments, :person_id
    add_index :public_scores, :service_id
    add_index :public_scores, :person_id
    add_index :service_regulator_scores, :service_id

    # foreign key constraints
    execute(MigrationHelper.foreign_key(:addresses, :country_id, :countries))
    execute(MigrationHelper.foreign_key(:addresses, :address_type_id, :address_types))
    execute(MigrationHelper.foreign_key(:addresses, :organisation_id, :organisations))
    execute(MigrationHelper.foreign_key(:addresses, :person_id, :people))
    execute(MigrationHelper.foreign_key(:ownerships, :organisation_id, :organisations))
    execute(MigrationHelper.foreign_key(:ownerships, :owning_organisation_id, :organisations, 'fk_ownerships_owning_org'))
    execute(MigrationHelper.foreign_key(:ownerships, :person_id, :people))
    execute(MigrationHelper.foreign_key(:ownerships, :ownership_type_id, :ownership_types))
    execute(MigrationHelper.foreign_key(:employments, :organisation_id, :organisations))
    execute(MigrationHelper.foreign_key(:employments, :person_id, :people))
    execute(MigrationHelper.foreign_key(:phones, :country_id, :countries))
    execute(MigrationHelper.foreign_key(:phones, :address_type_id, :address_types))
    execute(MigrationHelper.foreign_key(:phones, :organisation_id, :organisations))
    execute(MigrationHelper.foreign_key(:phones, :person_id, :people))
    execute(MigrationHelper.foreign_key(:regulators, :organisation_id, :organisations))
    execute(MigrationHelper.foreign_key(:services, :regulator_service_type_id, :regulator_service_types))
    execute(MigrationHelper.foreign_key(:services, :regulator_id, :regulators))
    execute(MigrationHelper.foreign_key(:services, :organisation_id, :organisations))
    execute(MigrationHelper.foreign_key(:services, :regulator_sector_type_id, :regulator_sector_types))
    execute(MigrationHelper.foreign_key(:regulator_scores, :internal_regulator_score_id, :internal_regulator_scores))
    execute(MigrationHelper.foreign_key(:regulator_scores, :regulator_id, :regulators))
    execute(MigrationHelper.foreign_key(:regulator_sector_types, :regulator_id, :regulators))
    execute(MigrationHelper.foreign_key(:regulator_sector_types, :internal_sector_type_id, :internal_sector_types))
    execute(MigrationHelper.foreign_key(:regulator_service_types, :internal_service_type_id, :internal_service_types))
    execute(MigrationHelper.foreign_key(:regulator_service_types, :regulator_id, :regulators))
    execute(MigrationHelper.foreign_key(:comments, :public_score_id, :public_scores))
    execute(MigrationHelper.foreign_key(:comments, :person_id, :people))
    execute(MigrationHelper.foreign_key(:public_scores, :service_id, :services))
    execute(MigrationHelper.foreign_key(:public_scores, :person_id, :people))
    execute(MigrationHelper.foreign_key(:public_scores, :public_scores_status_id, :public_scores_statuses))
    execute(MigrationHelper.foreign_key(:service_regulator_scores, :regulator_score_id, :regulator_scores))
    execute(MigrationHelper.foreign_key(:service_regulator_scores, :service_id, :services))
  end

  def self.down
    # foreign key constraints
    execute(MigrationHelper.drop_foreign_key(:addresses, :countries))
    execute(MigrationHelper.drop_foreign_key(:addresses, :address_types))
    execute(MigrationHelper.drop_foreign_key(:addresses, :organisations))
    execute(MigrationHelper.drop_foreign_key(:addresses, :people))
    execute(MigrationHelper.drop_foreign_key(:ownerships, :organisations))
    execute(MigrationHelper.drop_foreign_key(:ownerships, :organisations, 'fk_ownerships_owning_org'))
    execute(MigrationHelper.drop_foreign_key(:ownerships, :people))
    execute(MigrationHelper.drop_foreign_key(:ownerships, :ownership_types))
    execute(MigrationHelper.drop_foreign_key(:employments, :organisations))
    execute(MigrationHelper.drop_foreign_key(:employments, :people))
    execute(MigrationHelper.drop_foreign_key(:phones, :countries))
    execute(MigrationHelper.drop_foreign_key(:phones, :address_types))
    execute(MigrationHelper.drop_foreign_key(:phones, :organisations))
    execute(MigrationHelper.drop_foreign_key(:phones, :people))
    execute(MigrationHelper.drop_foreign_key(:regulators, :organisations))
    execute(MigrationHelper.drop_foreign_key(:services, :regulator_service_types))
    execute(MigrationHelper.drop_foreign_key(:services, :regulators))
    execute(MigrationHelper.drop_foreign_key(:services, :organisations))
    execute(MigrationHelper.drop_foreign_key(:services, :regulator_sector_types))
    execute(MigrationHelper.drop_foreign_key(:regulator_scores, :internal_regulator_scores))
    execute(MigrationHelper.drop_foreign_key(:regulator_scores, :regulators))
    execute(MigrationHelper.drop_foreign_key(:regulator_sector_types, :regulators))
    execute(MigrationHelper.drop_foreign_key(:regulator_sector_types, :internal_sector_types))
    execute(MigrationHelper.drop_foreign_key(:regulator_service_types, :internal_service_types))
    execute(MigrationHelper.drop_foreign_key(:regulator_service_types, :regulators))
    execute(MigrationHelper.drop_foreign_key(:comments, :public_scores))
    execute(MigrationHelper.drop_foreign_key(:comments, :people))
    execute(MigrationHelper.drop_foreign_key(:public_scores, :services))
    execute(MigrationHelper.drop_foreign_key(:public_scores, :people))
    execute(MigrationHelper.drop_foreign_key(:public_scores, :public_scores_status))
    execute(MigrationHelper.drop_foreign_key(:service_regulator_scores, :regulator_scores))
    execute(MigrationHelper.drop_foreign_key(:service_regulator_scores, :services))

    # indexes
    remove_index :addresses, :organisation_id
    remove_index :addresses, :person_id
    remove_index :ownerships, :organisation_id
    remove_index :ownerships, :owning_organisation_id
    remove_index :ownerships, :person_id
    remove_index :employments, :organisation_id
    remove_index :employments, :person_id
    remove_index :phones, :organisation_id
    remove_index :phones, :person_id
    remove_index :services, :organisation_id
    remove_index :comments, :person_id
    remove_index :public_scores, :service_id
    remove_index :public_scores, :person_id
    remove_index :service_regulator_scores, :service_id

  end
end
