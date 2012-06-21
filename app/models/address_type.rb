class AddressType < ActiveRecord::Base
  validates :description, :presence => true
  has_many :addresses
  has_many :phones
end
