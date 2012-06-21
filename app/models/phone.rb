class Phone < ActiveRecord::Base
  belongs_to :country
  belongs_to :phone_type
  belongs_to :organisation
  belongs_to :person
  belongs_to :address_type

  attr_accessible :number
end
