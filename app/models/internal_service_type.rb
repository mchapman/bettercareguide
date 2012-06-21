class InternalServiceType < ActiveRecord::Base
  validates :description, :presence => true
  has_many :regulator_service_types
  has_many :registrations

  attr_accessor :type_count
  attr_accessible :description, :requires_type_col, :sort_order, :seo_keywords

  def InternalServiceType.res_types
    if Rails.env.test?
      # caching breaks the tests
      InternalServiceType.find_all_by_description(['Care in a Residential Home', 'Care in a Nursing Home']).collect {|type| type[:id]}
    else
      @res_types ||= InternalServiceType.find_all_by_description(['Care in a Residential Home', 'Care in a Nursing Home']).collect {|type| type[:id]}
    end
  end

  def InternalServiceType.dom_type
    if Rails.env.test?
      # caching breaks the tests
      InternalServiceType.find_by_description(['Care at Home']).id
    else
      @dom_type ||= InternalServiceType.find_by_description(['Care at Home']).id
    end
  end

  def InternalServiceType.get_description(id)
    @cache ||= []
    element = @cache.index {|x| x[0] == id}
    if element
      element = @cache[element]
    else
      element = [id, find(id).description]
      @cache << element
    end
    element[1]
  end

end
