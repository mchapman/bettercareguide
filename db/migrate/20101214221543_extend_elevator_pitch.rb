class ExtendElevatorPitch < ActiveRecord::Migration
  def self.up
    change_column :services, :elevator_pitch, :string, :limit => 150;
  end

  def self.down
    change_column :services, :elevator_pitch, :string, :limit => 100;
  end
end
