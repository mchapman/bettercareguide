class NewFieldsForOrg < ActiveRecord::Migration
  def self.up
    add_column :organisations, :main_email, :string
    add_column :organisations, :twitter, :string, :limit => 20
    add_column :people, :main_email, :string
    add_column :people, :twitter, :string, :limit => 20
    add_column :employments, :main_email, :string
    add_column :employments, :twitter, :string, :limit => 20
    add_column :services, :regulator_id, :integer
    add_column :services, :regulator_given_id, :string, :limit => 20

    add_index :registrations, :service_id
    add_index :registrations, :regulator_id
    add_index :registrations, :organisation_id

    previous = nil
    Registration.select('service_id, regulator_id, regulator_given_id').order('service_id, updated_at DESC').each do |r|
      if previous != r.service_id
        service = Service.find r.service_id
        service.update_attributes(:regulator_id => r.regulator_id, :regulator_given_id => r.regulator_given_id)
        previous = r.service_id
      end
    end

    s = Service.find(31619)
    s.deregistration_date = Time.new(1980,1,1)
    s.save!
  end

  def self.down
    remove_column :organisations, :main_email
    remove_column :organisations, :twitter
    remove_column :people, :main_email
    remove_column :people, :twitter
    remove_column :employments, :main_email
    remove_column :employments, :twitter
    remove_column :services, :regulator_id
    remove_column :services, :regulator_given_id

    remove_index :registrations, :service_id
    remove_index :registrations, :regulator_id
    remove_index :registrations, :organisation_id
  end
end
