class GeneraliseRegulation < ActiveRecord::Migration

  class Registration < ActiveRecord::Base
  end

  def self.up
    add_column :regulators, :regulation_type, :integer
    add_column :organisations, :internal_sector_type_id, :integer
    add_column :services, :internal_service_type_id, :integer

    create_table :registrations do |t|
      t.references  :regulator
      t.references  :service
      t.references  :organisation
      t.string      :regulator_given_id
      t.date        :effective_date
      t.references  :regulator_score
      t.references  :regulator_service_type
      t.timestamps
    end

    Service.reset_column_information
    Organisation.reset_column_information

    # Convert service_regulator_scores to registrations
    Registration.reset_column_information
    ServiceRegulatorScore.all.each do |s|
      Registration.create(:regulator_id               => s.regulator_score.regulator_id,
                          :service_id                 => s.service_id,
                          :regulator_given_id         => s.service.regulator_service_ref,
                          :effective_date             => s.effective_date,
                          :regulator_score_id         => s.regulator_score_id,
                          :regulator_service_type_id  => s.service.regulator_service_type_id,
                          :created_at                 => s.created_at)
    end

    Service.all.each do |s|
      if s.regulator_sector_type && s.regulator_sector_type.internal_sector_type_id
        o = Organisation.find(s.organisation_id)
        # Get rid of regulator_sector_types to organisations
        o.internal_sector_type_id = s.regulator_sector_type.internal_sector_type_id
        o.save!
      end

      if s.regulator_service_type && s.regulator_service_type.internal_service_type_id
        # Get rid of regulator_service_types
        s.internal_service_type_id = s.regulator_service_type.internal_service_type_id
        s.save!
      end
    end

    remove_column :services, :regulator_service_ref
    remove_column :services, :regulator_id
    remove_column :services, :regulator_service_type_id
    remove_column :services, :regulator_sector_type_id
    rename_column :services, :registration_date, :date_started_trading
    rename_column :services, :registration_date_implied, :date_started_trading_implied
    # get rid of a stupid table
    drop_table :service_links
    # get rid of ported tables
    drop_table :service_regulator_scores
  end

  def self.down
    puts "Probably better to do a restore"
    drop_table :registrations
  end
end
