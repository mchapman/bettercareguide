class RegulatorSectorType < ActiveRecord::Base
  validates :regulator_description, :presence => true
  belongs_to :regulator
  belongs_to :internal_sector_type

  attr_accessible :regulator_description, :regulator_id, :internal_sector_type_id
end
