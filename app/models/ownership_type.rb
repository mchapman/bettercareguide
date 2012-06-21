class OwnershipType < ActiveRecord::Base
  validates :description, :presence => true
  has_one :ownership
end
