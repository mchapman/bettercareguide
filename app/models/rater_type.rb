class RaterType < ActiveRecord::Base
  has_many :ratings
  validates :short_description, :long_description, :presence => true

  attr_accessible :short_description, :long_description
end
