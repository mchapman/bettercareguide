require "tropo-webapi-ruby"
require "open-uri"

class VoiceController < ApplicationController

  skip_before_filter :verify_authenticity_token

  EXT = 'wav'

  def prompt_for_provider_phone_no(tropo_generator)
    tropo_generator.ask :name => 'service_number',
                        :bargein => true,
                        :timeout => 60,
                        :attempts => 2,
                        :voice => "kate",
                        :say => [{:event => "timeout", :value => "Sorry, I did not hear anything."},
                                 {:event => "nomatch:1 nomatch:2", :value => "I'm sorry, that wasn't an eleven digit phone number.  Please try again."},
                                 {:value => "Please enter the telephone number, including S.T.D. code, of the provider you would like to review"}],
                        :choices => {:value => "[11 DIGITS]"}
    tropo_generator.on :event => 'hangup', :next => '/voice/hangup'
    tropo_generator.on :event => 'continue', :next => '/voice/process_service_number'
  end

  def twilio_get_provider_phone_no(r)
    r.Gather :numDigits => 11, :action => "/voice/twilio_process_service_number", :method => 'POST' do |r|
      r.Play "http://bettercareguide.s3.amazonaws.com/prompts/enter_phone_number.#{EXT}"
    end
  end

  def create_rating(phone_no, session_id, service)
    rating = Rating.new
    rating.phone = phone_no
    rating.ivr_session = session_id
    rating.stars = -1
    rating.creation_ip_address = service
    rating.status_mask = Rating::status_bit(:incomplete_phone)
    rating.save(:validate => false)
  end

  def twilio_index
    call_id = params[:CallSid]
    case params[:CallStatus]
      when "in-progress", "ringing"
        phone_no = params[:Caller]
        response = Twilio::TwiML::Response.new do |r|
          if phone_no =~ /(0[1-2]|client:sandbox|44[1-2])/
            create_rating(phone_no, call_id, 'Twilio')
            r.Play "http://bettercareguide.s3.amazonaws.com/prompts/welcome.#{EXT}"
            r.Play "http://bettercareguide.s3.amazonaws.com/prompts/get_name.#{EXT}"
            r.Record :action => "/voice/twilio_captured_name", :method => 'POST', :finishOnKey => '#', :maxLength => 60
          else
            r.Reject
            r.Play "http://bettercareguide.s3.amazonaws.com/prompts/welcome_mobile.#{EXT}"
          end
        end
        render :xml => response.text
      when "completed"
        internal_hangup(call_id)
      else
        Rails.logger.error "Twilio - unhandled call status #{params[:CallStatus]}"
    end
  end

  def twilio_captured_name
    call_id = params[:CallSid]
    rating = Rating.find_by_ivr_session(call_id)
    if false
      # Don't bother to transfer the recording until we have 10k minutes - probably never
      # internal_store_recording(rating, open(params[:RecordingUrl]), :name)
    else
      rating.name_recording_url = params[:RecordingUrl]
      rating.save(:validate => false)
    end
    response = Twilio::TwiML::Response.new do |r|
      twilio_get_provider_phone_no(r)
    end
    render :xml => response.text
  end

  def index
    raise "Tropo needs to capture the caller name"
    tropo_session_from = params[:session][:from]
    network = tropo_session_from[:network]
    channel = tropo_session_from[:channel]
    call_id = params[:session][:callId]

    t = Tropo::Generator.new
    if network == "SMS" || network == "JABBER"
      t.say :value => "Hello, welcome to the BetterCareGuide.org.  Sorry - we have no support for #{network} yet.",
            :voice => "kate"
    elsif channel == "VOICE"
      if (tropo_session_from[:id] =~ /44[1-2]/) || (network == 'SKYPE')
        create_rating(tropo_session_from[:id], call_id, 'Tropo')
        t.say :value => "Hello, welcome to the Better Care Guide dot org.",
              :voice => "kate"
        prompt_for_provider_phone_no(t)
      else
        t.say :value => "Hello, welcome to the Better Care Guide dot org.  This service can only be used from landlines - please call again.  Goodbye.",
              :voice => "kate"
      end
    else
      t.say :value => "Hello, welcome to the BetterCareGuide.org.  Sorry - we have no support for #{channel} on #{network} yet.",
            :voice => "kate"
    end
    render :json => t.response
  end

  def hangup
    # Tropo call has hung up
    internal_hangup(params[:result][:callId])
  end

  def internal_hangup(call_id)
    # They have hung up without completing the process - delete the incomplete review here is we are going to
    rating = Rating.find_by_ivr_session(call_id)
    if rating
      if rating.has_status(:incomplete_phone)
        rating.delete
      else
        Rails.logger.error "Expected to find a rating with an incomplete status here"
      end
    else
      Rails.logger.error "Expected to find a matching rating here"
    end
    render :text => "Hung Up"
  end

  def get_service_from_phone(phone_no, session_id)
    service_name = nil
    if phone_no.length == 11
      s = Service.joins(:reg_phones).where("deregistration_date is null and number similar to '%#{phone_no.split(//).join('%')}%'")
      number_found = s.length
      if number_found == 1
        service = s.first
        Rating.find_by_ivr_session(session_id).update_attribute(:service_id, service.id)
        service_name = service.organisation.name
      elsif  number_found > 1
        begin
          raise "Data error - services need deduping for phone number #{phone_no}"
        rescue => exception
          if Rails.env.production?
            ExceptionNotifier::Notifier.exception_notification(request.env, exception, :data => {:message => "Data error - services need deduping for phone number #{phone_no}"}).deliver
          else
            Rails.logger.error exception.message
          end
        end
      end
    else
      number_found = 0
    end
    return service_name, number_found
  end

  def process_service_number
    service_name, number_found = get_service_from_phone(params[:result][:actions][:interpretation], params[:result][:callId])
    t = Tropo::Generator.new
    case number_found
      when 1
        t.ask :name => 'service_confirm',
              :bargein => true,
              :timeout => 5,
              :attempts => 2,
              :voice => "kate",
              :say => [{:event => "timeout", :value => "Sorry, I did not hear anything."},
                       {:event => "nomatch:1 nomatch:2", :value => "I'm sorry, I didn't understand.  Please try again."},
                       {:value => "<speak>Please confirm that you would like to review <emphasis>#{service_name}</emphasis>.  Say <emphasis>yes</emphasis> or press 1 to confirm, say <emphasis>no</emphasis> or press 2 to change selection</speak>"}],
              :choices => {:value => "true(1,yes), false(2,no)"}
        t.on :event => 'hangup', :next => '/voice/hangup'
        t.on :event => 'continue', :next => '/voice/confirm_service_number'
      when 0
        t.say :value => "I couldn't find a service with that phone number.  Please try again.", :voice => "kate"
        prompt_for_provider_phone_no(t)
      else
        t.say :value => "I'm afraid we have more than one service with that number.  We will sort the data out shortly - please tray again in a day or so.  Goodbye", :voice => "kate"
        internal_hangup(params[:result][:callId])
        t.hangup
    end
    render :json => t.response
  end

  def twilio_process_service_number
    service_name, number_found = get_service_from_phone(params[:Digits], params[:CallSid])
    response = Twilio::TwiML::Response.new do |r|
      case number_found
        when 1
          r.Gather :numDigits => 1, :action => "/voice/twilio_confirm_service_number", :method => 'POST' do |r|
            r.Play "http://bettercareguide.s3.amazonaws.com/prompts/confirm.#{EXT}"
            r.Say service_name, :voice => 'man', :language => 'en-gb'
            r.Play "http://bettercareguide.s3.amazonaws.com/prompts/offer_change.#{EXT}"
          end
        when 0
          r.Play "http://bettercareguide.s3.amazonaws.com/prompts/not_found.#{EXT}"
          twilio_get_provider_phone_no(r)
        else
          r.Play "http://bettercareguide.s3.amazonaws.com/prompts/data_dupe.#{EXT}"
          r.hangup # This will call twilio_index which will do the tidy up
      end
    end
    render :xml => response.text
  end

  def confirm_service_number
    call_id = params[:result][:callId]
    confirm = params[:result][:actions][:concept]
    t = Tropo::Generator.new
    if confirm
      t.ask :name => 'reviewer_type',
            :bargein => true,
            :timeout => 5,
            :attempts => 2,
            :voice => "kate",
            :say => [{:event => "timeout", :value => "Sorry, I did not hear anything."},
                     {:event => "nomatch:1 nomatch:2", :value => "I'm sorry, I didn't understand.  Please try again."},
                     {:value => "<speak>You now have five options.  You needn't wait to hear all of them.  Press or say <emphasis>one</emphasis> if you are someone who uses the service.  Answer <emphasis>two</emphasis> if you are a family member of someone who uses the service. " +
                         "Answer <emphasis>three</emphasis> if you are employed by the service provider.  If you are a care professional working alongside the service provider answer <emphasis>four</emphasis>.  Press or say <emphasis>five</emphasis> if you are some  other connection to the service.</speak>"}],
            :choices => {:value => "1(1,one), 2(2,two), 3(3,three), 4(4,four), 5(5,five)"}

      t.ask :name => 'stars',
            :bargein => true,
            :timeout => 5,
            :attempts => 2,
            :voice => "kate",
            :say => [{:event => "timeout", :value => "Sorry, I did not hear anything."},
                     {:event => "nomatch:1 nomatch:2", :value => "I'm sorry, I didn't understand.  Please try again."},
                     {:value => "<speak>On  a  scale of <emphasis>one</emphasis> to <emphasis>five</emphasis>, where one is <emphasis>worst</emphasis> and five is <emphasis>best</emphasis>, how would you rank this service?</speak>"}],
            :choices => {:value => "1(1,one), 2(2,two), 3(3,three), 4(4,four), 5(5,five)"}

      t.record :say => [{:value => "After the beep please tell me your name, followed by what you think about the service.  Then press the hash key.  You can speak for  up to 60 seconds."},
                        {:value => "Sorry, I did not hear anything. Please call back.", :event => "timeout"}],
               :name => "review_audio",
               :maxTime => 60.0,
               :required => true,
               :timeout => 5.0,
               :voice => "kate",
               :beep => true,
               :format => 'audio/mp3',
               :url => "/voice/capture_recording",
               :choices => {:terminator => "#"}
      t.on :event => 'hangup', :next => '/voice/hangup'
      t.on :event => 'continue', :next => '/voice/after_review'
    else
      prompt_for_provider_phone_no(t)
      t.on :event => 'hangup', :next => '/voice/hangup'
      t.on :event => 'continue', :next => '/voice/process_service_number'
    end
    render :json => t.response
  end

  def twilio_prompt_for_reviewer(r)
    r.Gather :numDigits => 1, :action => "/voice/twilio_got_reviewer_type", :method => 'POST' do |r|
      r.Play "http://bettercareguide.s3.amazonaws.com/prompts/reviewer_type.#{EXT}"
    end
  end

  def twilio_confirm_service_number
    call_id = params[:CallSid]
    confirm = (params[:Digits] == "1")
    response = Twilio::TwiML::Response.new do |r|
      if confirm
        twilio_prompt_for_reviewer(r)
      else
        twilio_get_provider_phone_no(r)
      end
    end
    render :xml => response.text
  end

  def twilio_got_reviewer_type
    call_id = params[:CallSid]
    reviewer_type = params[:Digits].to_i
    response = Twilio::TwiML::Response.new do |r|
      if reviewer_type >= 1 and reviewer_type <= 5
        rating = Rating.find_by_ivr_session(call_id)
        rating.rater_type_id = reviewer_type
        rating.save(:validate => false)
        twilio_prompt_for_stars(r)
      else
        r.Play "http://bettercareguide.s3.amazonaws.com/prompts/didnt_understand.#{EXT}"
        twilio_prompt_for_reviewer(r)
      end
    end
    render :xml => response.text
  end

  def twilio_prompt_for_stars(r)
    r.Gather :numDigits => 1, :action => "/voice/twilio_got_stars", :method => 'POST' do |r|
      r.Play "http://bettercareguide.s3.amazonaws.com/prompts/stars.#{EXT}"
    end
  end

  def twilio_got_stars
    call_id = params[:CallSid]
    stars = params[:Digits].to_i
    response = Twilio::TwiML::Response.new do |r|
      if stars >= 1 and stars <= 5
        rating = Rating.find_by_ivr_session(call_id)
        rating.stars = stars
        rating.save(:validate => false)
        r.Play "http://bettercareguide.s3.amazonaws.com/prompts/speak_now.#{EXT}"
        r.Record :action => "/voice/twilio_capture_recording", :method => 'POST', :finishOnKey => '#', :maxLength => 60
      else
#        r.Say "I am sorry, I didn't understand that.", :voice => 'man', :language => 'en-gb'
        r.Play "http://bettercareguide.s3.amazonaws.com/prompts/didnt_understand.#{EXT}"
        twilio_prompt_for_stars(r)
      end
    end
    render :xml => response.text
  end

  def capture_recording
    # Tropo stupidly doesn't pass the call_id, so we need to try and figure it out
    rating = Rating.where("ivr_session is not null and creation_ip_address = 'Tropo'").order('updated_at desc').first
    rating.remove_status(:incomplete_phone) if rating.stars != -1 and not rating.rater_type_id.blank?
    internal_store_recording(rating, params[:filename].tempfile, :review)
    render :text => 'OK'
  end

  def twilio_capture_recording
    call_id = params[:CallSid]
    rating = Rating.find_by_ivr_session(call_id)
    rating.remove_status(:incomplete_phone)
    if false
# Don't bother the transfer until we are approaching 10k minutes - probably never!
#    internal_store_recording(rating, open(params[:RecordingUrl]), :review)
    else
      rating.add_status(:needs_transcription)
      rating.recording_url = params[:RecordingUrl]
      rating.save(:validate => false)
    end
    response = Twilio::TwiML::Response.new do |r|
      # TODO: need to accept terms and conditions
      r.Play "http://bettercareguide.s3.amazonaws.com/prompts/thank_you.#{EXT}"
      r.Hangup
    end
    render :xml => response.text
  end

  def internal_store_recording(rating, file, type)
    if type == :review
      letter = 'R'
      attribute = :recording_url
      rating.add_status(:needs_transcription)
    else
      letter = 'N'
      attribute = :name_recording_url
    end
    url = rating.ivr_session+letter+'.wav'
    result = AWS::S3::S3Object.store(url, file, "bettercareguide/recordings", :content_type => 'audio/wav', :access => :public_read)
    rating[attribute] = "http://bettercareguide.s3.amazonaws.com/recordings/#{url}"
    rating.save(:validate => false)
  end

  def after_review
    t = Tropo::Generator.new
    rating = Rating.find_by_ivr_session(params[:result][:callId])
    actions = params[:result][:actions]
    rating.stars = actions[actions.index { |x| x[:name]=="stars" }][:concept]
    rating.rater_type_id = actions[actions.index { |x| x[:name]=="reviewer_type" }][:concept]
    rating.remove_status(:incomplete_phone) if rating.has_status(:needs_transcription)
    rating.save(:validate => false)
# TODO: need to accept terms and conditions
    t.say :value => "Thank you.  Goodbye.",
          :voice => "kate"
    t.hangup
    render :json => t.response
  end

end
