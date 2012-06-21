class Town < ActiveRecord::Base

  DELTA = 0.001

  validates :lat, :lng, :presence => true
  validates :name, :presence => true, :length => {:maximum => 60}
  validates_uniqueness_of :name, :case_sensitive => false

  geocoded_by :ukname, :latitude  => :lat, :longitude => :lng

  before_validation do
    if self.lat and self.lng and self.lat.abs < DELTA and self.lng.abs < DELTA
      self.lat, self.lng = nil
    end
  end

  after_validation do
    if self.lat == nil || self.lng == nil
      self.fetch_coordinates
    end
  end

  def ukname
    self.name + ',UK'
  end

  # Get the rough high/low lat/long bounds for a geographic point and
  # radius. Returns an array: <tt>[lat_lo, lat_hi, lon_lo, lon_hi]</tt>.
  # Used to constrain search to a (radius x radius) square.
  #
  def Town.internal_coordinate_bounds(radius, vlat, vlng)
    radius = radius.to_f
    factor = (Math::cos(vlat * Math::PI / 180.0) * 69.0).abs
    "Lat BETWEEN #{vlat - (radius / 69.0)} AND #{vlat + (radius / 69.0)} AND Lng BETWEEN #{vlng - (radius / factor)} AND #{vlng + (radius / factor)}"
  end

  def geocoded
    lat != nil and lng != nil
  end

  def Town.fetch_coordinates_using_cache(geog, radius)
    lat, lng = nil, nil
    if geog
      geog_up = geog.upcase
      is_postcode = ((geog_up =~ /(GIR 0AA)|(((A[BL]|B[ABDHLNRSTX]?|C[ABFHMORTVW]|D[ADEGHLNTY]|E[HNX]?|F[KY]|G[LUY]?|H[ADGPRSUX]|I[GMPV]|JE|K[ATWY]|L[ADELNSU]?|M[EKL]?|N[EGNPRW]?|O[LX]|P[AEHLOR]|R[GHM]|S[AEGKLMNOPRSTY]?|T[ADFNQRSW]|UB|W[ADFNRSV]|YO|ZE)[1-9]?[0-9]|((E|N|NW|SE|SW|W)1|EC[1-4]|WC[12])[A-HJKMNPR-Y]|(SW|W)([2-9]|[1-9][0-9])|EC[1-9][0-9]) [0-9][ABD-HJLNP-UW-Z]{2})/) == 0)
      # If is a postcode - see if we have it on file already
      if is_postcode && (a = Address.find_by_postal_zip_code(geog_up)) != nil
        lat, lng = a.lat, a.lng
      elsif !is_postcode && (town = Town.find_by_name(geog_up)) != nil
        lat, lng = town.lat, town.lng
      else
        Rails.logger.info "!!!!!!! Server doing geocoding"
        town = Town.new
        town.name = geog_up
        town.fetch_coordinates
        if town.geocoded
          lat, lng = town.lat, town.lng
          town.save if geog_up =~ /^[A-Z -'!]+$/
        else
          Rails.logger.info "!!!!!!! FAILED - #{geog_up}"
        end
      end
    end
    if lat && lng
      return lat, lng, internal_coordinate_bounds(radius, lat, lng)
    else
      return nil, nil, nil
    end
  end

end
