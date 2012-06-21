class PagesController < ApplicationController

# Note that there is no authorisation here - everyone has access to everything

  def contact
    @subtitle = 'Contact'
    @description = 'How to contact ReallyCare CIC about the Better Care Guide (post and electronic)'
  end

  def about
    @subtitle = 'About'
    @description = 'About the Better Care Guide and ReallyCare CIC - company behind it'
  end

  def terms
    @subtitle = 'Terms and Conditions'
    @description = 'Terms and conditions of the Better Care Guide - nothing unusual here'
  end

  def privacy
    @subtitle = 'Privacy'
    @description = 'The full privacy policy for the Better Care Guide'
  end

  def cookie_policy
    @subtitle = 'Cookies'
    @description = 'How we use cookies'
  end

  def accept_cookies
    #TODO Do this with unobtrusive JS (:remote => true on the form)
    cookies[:eucookie] = {:value => 'OK', :expires => 10.years.from_now }
    redirect_target = request.env["HTTP_REFERER"] ? request.env["HTTP_REFERER"] : :root
    redirect_to redirect_target
  end

  def help
    @subtitle = 'Help'
    @description = 'Simple help page for Better Care Guide - contains details of our support site'
  end

  def opensource
    @subtitle = 'Open Source'
    @description = 'Information about our commitment to open source and open data'
  end

  def provider_guide
    @subtitle = 'Provider Guide'
    @description = 'An introduction for providers, showing how to register with the site and the advantages of doing so'
  end

  def textile
    @subtitle = 'Introduction to textile markup in the Better Care Guide'
    @description = 'Introduction to textile markup in the Better Care Guide, showing the subset that is supported'
  end

  def newsession
    reset_session
    redirect_to :root
  end

end
