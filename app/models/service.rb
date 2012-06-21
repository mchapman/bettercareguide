require 'string_extensions'

class Service < ActiveRecord::Base

  validates :elevator_pitch, :length => {:maximum => 150}
  validates :date_started_trading, :presence => true

  belongs_to :organisation
  belongs_to :internal_service_type
  belongs_to :regulator

  has_many :registrations, :order => "updated_at desc"
  has_many :permissions

  has_one :reg_address, :through => :organisation, :source => :addresses, :conditions => {:address_type_id => 1}
  has_many :reg_phones, :through => :organisation, :source => :phones, :conditions => {:address_type_id => 1}, :order => :phone_type_id

  accepts_nested_attributes_for :organisation, :permissions, :reg_address, :reg_phones
  attr_accessible :date_started_trading, :date_started_trading_implied, :description, :organisation_id, :internal_service_type_id, :invite_comment_up_to_stars, :capacity,
                  :organisation_attributes, :reg_address_attributes, :reg_phones_attributes, :elevator_pitch, :permissions_attributes

  extend FriendlyId
  friendly_id :my_friendly_id, use: [:slugged, :history]

  before_update do
    self.description = description.censored if !description.blank?
    self.elevator_pitch = elevator_pitch.censored if !elevator_pitch.blank?
  end

  def Service.home_page_select(type_list, provider, geog, radius, needs_type_col, page_no, client_lat, client_lng)
    results = nil
    ar_qry = Service.where('deregistration_date is null').where(:internal_service_type_id => type_list).joins(:organisation)
    error_msg = nil
    if type_list.empty?
      error_msg = 'You must tick at least one of the care types'
    elsif provider == nil and geog == nil
      error_msg = 'You must specify at least part of a provider name or a place'
    else
      ar_qry = ar_qry.where("organisations.name ilike ?", '%'+provider+'%') if provider
      sort_order = 'organisations.name'
      select_string = ar_qry.to_sql
      if not geog.blank?
        if client_lat.blank? || client_lng.blank?
          lat, lng, bounds_string = Town::fetch_coordinates_using_cache(geog, radius)
          if lat.blank? || lng.blank?
            error_msg = "Cannot work out where #{geog} is.  Please provide valid town / postcode / address."
          end
        else
          lat = client_lat.to_f
          lng = client_lng.to_f
          bounds_string = Town::internal_coordinate_bounds(radius, lat, lng)
        end
        unless error_msg
          distance = "3956 * 2 * ASIN(SQRT(POWER(SIN((#{lat} - Lat) * PI() / 180 / 2), 2) + COS(#{lat} * PI()/180) * COS(Lat * PI() / 180) * POWER(SIN((#{lng} - Lng) * PI() / 180 / 2), 2) ))"
          join_type = 'INNER'
          geocode_select = " AND " + bounds_string + " AND " + distance + " <= #{radius}"
          distance = ', ' + distance + ' as Distance'
          sort_order = 'Distance, organisations.name'
        end
      else
        join_type = 'LEFT OUTER'
        geocode_select = ''
        distance = ''
      end
      unless error_msg
        select_string = select_string.sub('WHERE', join_type + " JOIN addresses on addresses.organisation_id = organisations.id and addresses.address_type_id = 1 WHERE ") + geocode_select
        matching_count = find_by_sql(select_string.sub(/\"services\"\.\*/, "count(*) as MyCount"))[0]
        if matching_count[:mycount].to_i > 0
          select_string = select_string.sub(/\"services\"\.\*/, %{"services".*,'fake' as fake}) if type_list.length != 1 or needs_type_col
          select_string = select_string.sub(/\"services\"\.\*/, "services.id, services.elevator_pitch, services.cached_rating, services.slug,
                  coalesce(services.no_comments,0) as no_comments, organisations.name, addresses.line1,addresses.line2, addresses.line3, addresses.city, addresses.state,
                  addresses.postal_zip_code, phones.number, url,
                  services.internal_service_type_id " + distance)
          select_string = select_string.sub('WHERE', "LEFT OUTER JOIN phones on phones.organisation_id = organisations.id and phones.address_type_id = 1 and phones.phone_type_id = 1 WHERE")
          results = Service.paginate_by_sql(select_string + ' order by ' + sort_order, :page => page_no, :per_page => 10, :total => matching_count)
        end
      end
    end
    return results, error_msg
  end

  def current_registration
    @current_registration ||= get_current_registration
    @current_registration
  end

  def get_current_registration
    registration = nil
    registrations.each do |registration_rec|
      registration_regulator = registration_rec.regulator
      if registration_regulator.regulation_type == 1 and !registration_regulator.obsolete
        registration = registration_rec
        break
      end
    end
    registration
  end

  def regulator_rating
    rating_record = current_registration
    if rating_record
      score = rating_record.regulator_score_id
      RegulatorScore.find(score)
    else
      nil
    end
  end

  def regulator_rating_desc
    if reg_rating = regulator_rating #intentional assignment here
      reg_rating.regulator_description
    else
      'Not known'
    end
  end

  def update_rate_cache
    rating = Rating.where("service_id = ? and coalesce(status_mask,0) = 0", self.id).select('count(*) as my_count, sum(stars) as tot_stars').first
    if rating.my_count.to_i > 0
      self.no_comments = rating.my_count
      self.cached_rating = 20 * rating.tot_stars.to_i / rating.my_count.to_i
      self.save!
    end
  end

  def access_codes_from_user(user)
    Permission.outstanding_access_codes(user).where("service_id = ?", self.id)
  end

  def needs_access_code_from_user(user)
    access_codes_from_user(user).count == 1
  end

  def access_code_for_user(user)
    access_codes_from_user(user).first.id
  end

  def my_friendly_id
    my_slug = organisation.name.strip
    if reg_address
      city = reg_address.city.strip
      my_slug = my_slug + ' ' + city unless my_slug =~ %r{#{city}}
    end
    if internal_service_type
      service_type = internal_service_type.seo_single_word
      my_slug = my_slug + ' ' + service_type unless my_slug =~ %r{#{service_type}}
    end
    my_slug.gsub("'","")
  end

  def Service.find_from_regulator_given_key(regulator, given_key)
    Service.find_by_regulator_id_and_regulator_given_key(regulator, given_key)
  end

end
