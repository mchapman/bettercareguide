require 'string_extensions'

class Organisation < ActiveRecord::Base
  validates :name, :presence => true
  has_many :ownerships
  has_many :employments
  has_one :regulator
  belongs_to :internal_sector_type
  has_many :services
  has_many :addresses
  has_many :phones
  has_many :permissions
  has_many :registrations

  accepts_nested_attributes_for :addresses, :phones, :ownerships
  attr_accessible :name, :url, :internal_sector_type_id

  # return a pointer to the first address (in addresses) with the address_type_id of 1.  There should only be one.
  def registered_address
    self.addresses.each do |addr|
      if addr.address_type_id == 1
        return addr
      end
    end
    nil
  end

  def registered_address_landline
    self.phones.each do |phone|
      if phone.address_type_id == 1 and phone.phone_type_id == 1
        return phone
      end
    end
    nil
  end

  def registered_address_fax
    self.phones.each do |phone|
      if phone.address_type_id == 1 and phone.phone_type_id == 2
        return phone
      end
    end
    nil
  end

  def find_phone(phone_number, phone_type_id)
    self.phones.each do |phone|
      if phone.number == phone_number and phone.phone_type_id == phone_type_id
        return phone
      end
    end
    nil
  end

  # Check that changes are reasonable, and that records aren't being "subverted"
  before_validation(:on => :update) do
    if name_changed? and not (name.sounds_quite_like(name_was) || name[0..name_was.length-1] == name_was)
      errors[:name] << ': An organisation cannot change name that much.  If this causes you problems please let us know.'
      return false
    end
  end

end
