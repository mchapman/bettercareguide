class Regulator < ActiveRecord::Base
  validates :domain, :presence => true
  belongs_to :organisation
  has_many :registrations
  has_many :services
  has_many :regulator_scores
  has_many :regulator_sector_types
  has_many :regulator_service_types

  attr_accessor :registration_count

  attr_accessible :domain, :web_page_format, :organisation_id, :short_name, :description
end
