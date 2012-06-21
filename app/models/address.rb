class Address < ActiveRecord::Base

  DELTA = 0.001

  validates :line1, :city, :presence => true
  belongs_to :country
  belongs_to :organisation
  belongs_to :person
  belongs_to :address_type
  belongs_to :service
  attr_accessible :line1, :line2, :line3, :city, :state, :postal_zip_code, :country, :address_type

  geocoded_by :location, :latitude  => :lat, :longitude => :lng

  before_validation do
    if (self.lat and self.lng and self.lat.abs < DELTA and self.lng.abs < DELTA) or
            (Rails.env.production? && (line1_changed? or line2_changed? or line3_changed? or city_changed? or state_changed? or postal_zip_code_changed?))
      self.lat, self.lng = nil
    end
  end

  after_validation do
    if self.lat == nil || self.lng == nil
      self.fetch_coordinates
    end
  end

  def to_s
    self.line1.to_s + ' ' + self.line2.to_s + ' ' + self.line3.to_s + ' ' + self.city.to_s + ' ' + self.state.to_s + ' ' + self.postal_zip_code.to_s
  end

  def location
    [line1, line2, line3, city, state, postal_zip_code, country ? country.name : ''].compact.join(', ')
  end

  def coordinate_bounds(radius)
    Town::internal_coordinate_bounds(radius, lat, lng)
  end

  def probably_the_same_as(other_address)
    if self.postal_zip_code == other_address.postal_zip_code
      true
    else
      concurrence = 0
      a = self.to_s.split
      b = other_address.to_s.split
      a.each { |w| concurrence += 1 if b.index(w) }
      concurrence / a.length >= 0.8
    end
  end

end
