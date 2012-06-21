class Sendcode < ActionMailer::Base
  default :from => INCOMING_MAIL_PLAIN

  def make_instance_vars(permission, service, user)
    @permission = permission
    @service = service
    person = user.person
    @forename = person.given_name
    @surname = person.family_name
    @email = user.email
  end

  def by_fax(permission, service, user)
    make_instance_vars(permission, service, user)

    # fax via http://www.faxtastic.co.uk

    mail :to => INCOMING_MAIL_PLAIN, :subject => "Sending code by fax"
  end

  def by_landline(permission, service, user)
    make_instance_vars(permission, service, user)

    # text via http://www.txtlocal.co.uk or http://www.everymessage.com or twilio.com

    mail :to => INCOMING_MAIL_PLAIN, :subject => "Sending code by landline"
  end

  def by_mail(permission, service, user)
    make_instance_vars(permission, service, user)

    # mail via http://www.everymessage.com

    mail :to => INCOMING_MAIL_PLAIN, :subject => "Sending code by snail mail"
  end

  def rescan(service, user)
    make_instance_vars(nil, service, user)
    mail :to => INCOMING_MAIL_PLAIN, :subject => "Rescan a service"
  end

  def figure_something_out(service, contact, user)
    make_instance_vars(nil, service, user)
    @contact = contact
    @email = user.email
    mail :to => INCOMING_MAIL_PLAIN, :subject => "Figure something out"
  end

  def deregister(permission, service, user)
    make_instance_vars(permission, service, user)
    @greeting = "Hi"
    mail :to => @email, :subject => "Your service has been removed from #{SITE_TITLE}"
  end

end
