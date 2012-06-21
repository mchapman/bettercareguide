class AddCheckSumToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :checksum, :string, :limit => 40
  end
end
