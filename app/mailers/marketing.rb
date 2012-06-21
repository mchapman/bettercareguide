class Marketing < ActionMailer::Base
  default :from => INCOMING_MAIL_PLAIN
  # Subjects can be set in the I18n file at config/locales/en.yml
  # with lookups of the form:  en.ratings.inform_service_owner_publish.subject

  def not_england_providers(recipient)
    mail :to => recipient, :subject => 'Care provider comparison website'
  end

  def england_providers(recipient)
    mail :to => recipient, :subject => 'Care provider comparison website'
  end

  def england_directors(recipient)
    mail :to => recipient, :subject => 'Care provider comparison website'
  end

  def not_england_directors(recipient)
    mail :to => recipient, :subject => 'Care provider comparison website'
  end

  def newsletter20120418(recipient)
    mail :to => recipient, :subject => 'Better Care Guide News'
  end

  def newly_registered(service_id, recipient)
    @service = Service.find(service_id)
    mail :to => recipient, :subject => 'BetterCareGuide.org - a web site you may be interested in'
  end

end
