module RatingsHelper

  def service_display(rating)
    rating.service ? (link_to rating.service.organisation.name, "/services/#{rating.service_id}") : "None"
  end

  def rater_type_description(rating)
    rating.rater_type ? rating.rater_type.short_description : "Not known"
  end

end