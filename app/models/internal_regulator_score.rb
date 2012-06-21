class InternalRegulatorScore < ActiveRecord::Base
  validates :description, :presence => true
  has_many :regulator_scores

  attr_accessible :description, :value
end
