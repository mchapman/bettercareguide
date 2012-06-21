class Country < ActiveRecord::Base
  has_many :addresses
  has_many :phones
end
