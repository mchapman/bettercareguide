class RegulatorScore < ActiveRecord::Base
  validates :regulator_description, :presence => true
  belongs_to :internal_regulator_score
  belongs_to :regulator
  has_many :registrations
end
