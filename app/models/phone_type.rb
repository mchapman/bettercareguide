class PhoneType < ActiveRecord::Base
  validates :description, :presence => true
  has_many :phones
end
