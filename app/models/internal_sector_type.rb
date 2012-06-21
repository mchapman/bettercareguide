class InternalSectorType < ActiveRecord::Base
  validates :description, :presence => true
  has_many :regulator_sector_types
  has_many :organisations

  attr_accessible :description
end
