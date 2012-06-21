require 'redcloth'

class ServicesController < ApplicationController

  load_and_authorize_resource :except => [:show, :search, :home]

  DEFAULT_PROVIDER_MESSAGE = '<part of provider name>'
  DEFAULT_GEOG_MESSAGE = '<postcode or town>'

  def search
#TODO Look at https://github.com/provideal/tabulatr for this and other tables
# GET /search
    save_params_to_session
    flash.delete(:error) unless flash.empty?
    if session[:type_list] == []
      flash[:error] = 'You must specify the sort of care you are interested in.'
      redirect_to('/') and return
    end
    # For testing exception reporting
    #if session[:provider] && session[:provider][0..4] == 'raise'
    #  raise "This is an exception"
    #end
    @provlist, error_msg =Service.home_page_select(session[:type_list], session[:provider], session[:geog], session[:radius], session[:needs_type_col], params[:page], session[:lat], session[:lng])
    @distance_column = (session[:geog] and session[:geog] != "") ? true : false
    load_class_vars_from_session
    if @provlist == nil or @provlist.empty?
      error_msg = 'No results found - check your search criteria' if error_msg == nil
      flash[:error] = error_msg
      render 'home'
    elsif @provlist.total_entries == 1 && Rails.env.test? == false
      redirect_to("/services/#{@provlist[0][:id]}")
    end
    @needs_type_col = session[:needs_type_col]
    @description = 'List of providers that meet selection criteria, showing rating, number of reviews and provider summary.'
    @subtitle = 'Search results'
  end

  def home
    # GET /
    @subtitle = 'Find Better Care'
    @description = 'Better Care Guide is a comparison site to comment on adult social care providers, and find better care.  Search for care providers by name or area, and view ratings and reviews'
    load_class_vars_from_session
  end

  def claim
    # GET /services/1/claim
    if user_signed_in? && ((@service.organisation.url && @service.organisation.url.length > 4 && (email_domain(current_user.email) == url_domain(@service.organisation.url))) ||
        current_user.email == @service.organisation.main_email)
      Permission.auto_assign_service_ownership_to_user(@service, current_user)
    end
    @subtitle = "Claim #{@service.organisation.name}"
    @description = "Claim rights to update the record for #{@service.organisation.name}"
  end

  def sendcode
    # GET /services/1/sendcode
    if !current_user.person
      if params[:forename].blank? or params[:surname].blank?
        redirect_to(claim_path(@service), :alert => 'You must enter your forename and your surname.') and return
      else
        current_user.person = Person.create(
            :family_name => params[:surname],
            :given_name => params[:forename],
            :user => current_user)
      end
    end
    @ac_method = params[:ac_method]
    if @ac_method == 'rescan'
      Sendcode.rescan(@service, current_user).deliver
      redirect_to(root_url, :notice => 'We will be in touch by email.  We cannot guarantee timescales.')
    elsif @ac_method.blank?
      redirect_to(claim_path(@service), :alert => 'You must select a row from the options table.')
    elsif @ac_method == 'none'
      if params[:contact].blank?
        redirect_to(claim_path(@service), :alert => 'You must enter a contact number.')
      end
      Sendcode.figure_something_out(@service, params[:contact], current_user)
      redirect_to(root_url, :notice => 'We will be in touch.  We cannot guarantee timescales.')
    else
      permission = Permission.generate_access_code(@service, current_user)
      case @ac_method
        when 'fax'
          Sendcode.by_fax(permission, @service, current_user).deliver
          @chase = '30 minutes'
        when 'mail'
          Sendcode.by_mail(permission, @service, current_user).deliver
          @chase = '5 working days'
        when 'landline'
          Sendcode.by_landline(permission, @service, current_user).deliver
          @chase = '30 minutes'
      end
    end
  end

  def my_services
    @services = Permission.my_managed_services(current_user)
    case @services.count
      when 0
        redirect_to(root_url, :alert => 'You do not have access to any services.')
      when 1
        redirect_to (edit_service_path(@services.first.service_id))
      else
        @services = Permission.for_output(@services)
    end
  end

  def index
    redirect_to(root_url, :alert => 'Use search to narrow down the services selection.')
  end

  def show
    @service = Service.find(params[:id])
    if request.path != service_path(@service)
      redirect_to @service, status: :moved_permanently
    end
    @subtitle = @service.organisation.name
    @description = @service.elevator_pitch if @service.elevator_pitch
    @keywords = @service.reg_address.city + ', ' + @service.internal_service_type.seo_keywords
    @long_desc = @service.description ? RedCloth.new(@service.description).to_html.html_safe : ""
    if @service.no_comments and @service.no_comments > 0
      @comments = Rating::published_for_service_id(@service.id).includes(:rater_type).order(['coalesce(effective_date,cast(created_at as date)) desc', 'id desc'])
    else
      @comments = nil
    end
  end

  def new
    # GET /services/new
    # GET /services/new.xml
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @service }
    end
  end

  def edit
    # GET /services/1/edit
    @subtitle = @service.organisation.name
  end

  def create
    # POST /services
    # POST /services.xml
    if @service.save
      redirect_to(@service, :notice => 'Service was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    # PUT /services/1
    # PUT /services/1.xml
    redirect_dest = params[:commit] == 'Save' ? edit_service_path(@service) : @service

    if @service.update_attributes(params[:service])
      redirect_to(redirect_dest, :notice => 'Service was successfully updated')
    else
      render :action => "edit"
    end
  end

  def destroy
    # DELETE /services/1
    # DELETE /services/1.xml
    @service.destroy
    redirect_to(services_url)
  end

  private
  def load_class_vars_from_session
    @dom = session.empty? ? true : session[:dom]
    @res = session.empty? ? true : session[:res]
    @provider = (not session.empty? and session[:provider]) ? session[:provider] :''
    @geog = (not session.empty? and session[:geog]) ? session[:geog] :''
    @lat = (not session.empty? and session[:lat]) ? session[:lat] : ''
    @lng = (not session.empty? and session[:lng]) ? session[:lng] : ''
    @radius = (not session.empty? and session[:radius]) ? session[:radius] :'5'
  end

  def save_params_to_session
    session[:res] = (params[:res] == 'res')
    session[:dom] = (params[:dom] == 'dom')
    session[:lat] = params[:lat]
    session[:lng] = params[:lng]
    if session[:res]
      session[:type_list] = InternalServiceType.res_types
    else
      session[:type_list] = []
    end
    session[:type_list] << InternalServiceType.dom_type if session[:dom]
    session[:needs_type_col] = session[:type_list].length > 1
    session[:provider] = params[:provider] == DEFAULT_PROVIDER_MESSAGE ? nil : params[:provider]
    session[:geog] = params[:geog] == DEFAULT_GEOG_MESSAGE ? nil : params[:geog]
    session[:radius] = params[:radius]
  end

  def email_domain(email)
    email =~ /^[\w\.]*@([\w\-\.]*)\/?.*?$/ ? $1 : nil
  end

  def url_domain(url)
    url =~ /^(http:\/\/|)(www.|)([\w\-\.]*.(co.uk|com|org.uk|org|biz|ltd|gov.uk|ltd.co))\/?.*?$/ ? $3 : nil
  end
end
