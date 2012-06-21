class RatingsMsg < ActionMailer::Base
  default :from => INCOMING_MAIL_PLAIN
  # Subjects can be set in the I18n file at config/locales/en.yml
  # with lookups of the form:  en.ratings.inform_service_owner_publish.subject

  def inform_service_owner_publish(rating, recipient)
    @greeting = "Hi"
    @rating = rating
    mail :to => recipient.email, :subject => 'A rating for your care service has been published'
  end

  def inform_rater_publish(rating)
    @greeting = "Hi"
    @rating = rating
    mail :to => rating.rater.email, :subject => 'Your care service rating has been published!'
  end

  def request_service_owner_comments(rating, recipient)
    @greeting = "Hi"
    @rating = rating
    mail :to => recipient.email, :subject => 'A rating for your care service has been proposed'
  end

  def request_rater_comments
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  def inform_service_owner_gcg_publish(rating, recipient)
    @greeting = "Hi"
    @rating = rating
    mail :to => recipient.email, :subject => 'You have a new review on Good Care Guide'
  end

end
