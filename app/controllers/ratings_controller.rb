class RatingsController < ApplicationController

  def merge_errors_into(merge_into, merge_from)
    merge_from.each do |fieldname, msg|
      merge_into[fieldname] = [] if !merge_into[fieldname]
      merge_into[fieldname] << msg
    end
  end

  def common_set_up
    today = Time.now
    @start_year = today.year - 2
    @end_year = today.year
    @ip_address = request.remote_ip
    @rating.rater = current_user if current_user && @rating.rater == nil
  end

  def prepare
    # GET /ratings/(service id/slug)/prepare
    service = Service.find(params[:service_id])
    if service == nil
      redirect_to root_url, :alert => "No such service as #{params[:service_id]} found - find the service you want and then follow the link to add a review"
    end
    if request.path != rate_service_path(service)
      redirect_to rate_service_url(service), status: :moved_permanently
    end
    @subtitle = "Review #{service.organisation.name}"
    @description = "Prepare a review of #{service.organisation.name}"
    @rating = Rating.new(:service_id => service.id)
    common_set_up
    @url_ending = 'store'
  end

  def preview
    # GET /ratings/1/preview
    @rating = Rating.find(params[:id])
    authorize! :preview, Rating, request.remote_ip
  end

  def store
    # POST /ratings/store
    @rating = Rating.new(params[:rating])
    @rating.add_status(:pending_reallycare_approval) if Bc::Application.require_rating_checks == true
    @rating.creation_ip_address = request.remote_ip
    send_to_sign_in = false
    local_errors = ActiveModel::Errors.new(@rating)
    next_action = params[:commit] == 'Preview' ? :preview : :publish
    if current_user
      @rating.rater = current_user
    elsif @rating.rater_id
      # we have generated a user but they haven't logged in.  there was probably a validation error
    elsif !params[:email] || params[:email].empty?
      # must have a logged in user or an email
      local_errors[:email] << '- you must specify an email address (or log in, if you have registered)'
    else
      # create a new user (or try to, at least)
      @rating.add_status(:user_unconfirmed)
      @rating.rater = User.create_with_password(params[:email], params[:accepted_t_and_cs])
      if @rating.rater.errors.any?
        merge_errors_into(local_errors,@rating.rater.errors)
        @rating.rater = nil
        if local_errors[:email] && (i = local_errors[:email].find_index('has already been taken'))
          flash[:error] = 'Please log in to rate a service'
          redirect_to new_user_session_path
          send_to_sign_in = true
        end
      end
    end
#    @rating.service_id = params[:service_id]
    @rating.stars = params[:rate].to_i
    @rating.add_status(:preview_only)                          # gets removed later (in publish action) if we are publishing
    local_errors[:relevant_month] << '- either leave date blank or enter a month and year' if @rating.effective_date && (params[:rating]['effective_date(1i)'].empty? or params[:rating]['effective_date(2i)'].empty?)
#    local_errors[:relevant_month] << '- you cannot enter a date in the future' if @rating.effective_date > Time.new
    if local_errors.empty?                         # is everything OK this far?
      @rating.save                                   # try and save the record
    else
      @rating.valid?                                 # else generate error messages for rate so we get all of them at once
    end
    merge_errors_into(@rating.errors, local_errors)  # consolidate errors

    if send_to_sign_in
                                                         # throw away the data if they need to sign in (for now, at least)
    elsif @rating.errors.any?                            # if we have some errors
      @rating.service = Service.find(@rating.service_id) # set up the record,
      common_set_up
      @url_ending = 'store'
      render :action => "prepare"                        # show them and send them back to fix them
    elsif next_action == :preview
      redirect_to preview_rating_url(@rating.id)            # take them to preview screen
    else
      redirect_to publish_rating_url(@rating.id)            # publish the rating
    end
  end

  def publish
    @rating = Rating.find(params[:id])
    authorize! :publish, @rating, request.remote_ip
    @rating.remove_status(:preview_only, true)
  end

  def amend
    @rating = Rating.find(params[:id])
    authorize! :amend, @rating, request.remote_ip
    common_set_up
    @url_ending = 'modify'
  end

  def modify
    @rating = Rating.find(params[:id])
    authorize! :modify, @rating, request.remote_ip
    case params[:commit]
      when 'Publish'
        jump_to_url = publish_rating_url(@rating.id)
      when 'Preview'
        jump_to_url = preview_rating_url(@rating.id)
      when 'Abandon'
        redirect_to abandon_rating_url(@rating.id)
      else
        redirect_to root_url
    end
    @rating.stars = params[:rate].to_i
    if @rating.update_attributes(params[:rating])
      redirect_to jump_to_url
    else
      redirect_to amend_rating_url(@rating.id)
    end
  end

  def abandon
    @rating = Rating.find(params[:id])
    authorize! :abandon, @rating, request.remote_ip
    @rating.destroy
    redirect_to(root_url)
  end

  def index
  # GET /ratings
  # GET /ratings.xml
    authorize! :manage, Rating
    @ratings = Rating.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ratings }
    end
  end

  def show
  # GET /ratings/1
  # GET /ratings/1.xml
    authorize! :manage, Rating
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  def new
  # GET /ratings/new
  # GET /ratings/new.xml
    authorize! :manage, Rating
    @rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  def edit
  # GET /ratings/1/edit
    authorize! :manage, Rating
    @rating = Rating.find(params[:id])
#    params[:service_id] = @rating.service_id
    params[:rating] = @rating.stars
  end

  # GET /ratings/1/respond
  def respond
    @rating = Rating.find(params[:id])
    authorize! :respond, @rating
    if @rating.service.disable_rating_appeal and @rating.service.disable_rating_appeal >= Time.new
      @report_disabled = true
      @report_snippet = 'has caused'
      @report_snippet2 = " until #{@rating.service.disable_rating_appeal.strftime('%d %b %Y %H:%M')}"
    else
      @report_disabled = false
      @report_snippet = 'will cause'
      @report_snippet2 = ''
    end
  end

  def process_response
    @rating = Rating.find(params[:id])
    @rating.skip_publish_threshold_check = true
    @rating.add_status(:reported_by_provider) if params[:commit] == "Inform Site Admin"
    @rating.remove_status(:pending_service_owner)
    @rating.response_text= params[:rating][:response_text]
    @rating.response_datetime= Time.new
    @rating.response_ip_address= request.remote_ip
    @rating.response_user = current_user
    if @rating.save
      redirect_to(root_url, :notice => 'Rating was successfully updated.')
    else
      render :action => "respond"
    end
  end

  def create
  # POST /ratings
  # POST /ratings.xml
    authorize! :manage, Rating
    @rating = Rating.new(params[:rating])

    respond_to do |format|
      if @rating.save
        format.html { redirect_to(@rating, :notice => 'Rating was successfully created.') }
        format.xml  { render :xml => @rating, :status => :created, :location => @rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
  # PUT /ratings/1
  # PUT /ratings/1.xml
    authorize! :manage, Rating
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to(@rating, :notice => 'Rating was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  # DELETE /ratings/1
  # DELETE /ratings/1.xml
    authorize! :manage, Rating
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
