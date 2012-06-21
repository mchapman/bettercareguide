class UsersController < ApplicationController

  load_and_authorize_resource

  # GET /users
  # GET /users.xml
  def index
    @users = User.order('current_sign_in_at desc, created_at desc').paginate(:page => params[:page], :per_page => 10)
  end

  # GET /users/:id/dashboard
  def dashboard
    @access_codes = Permission.outstanding_access_codes(@user).sort_by_name
    @my_services = Permission.my_managed_services(@user).sort_by_name
    @ratings_to_process = @user.role?(:reallycare) ? Rating.where("status_mask & ? > 0",Rating::status_bit(:needs_transcription) + Rating::status_bit(:pending_reallycare_approval) + Rating::status_bit(:reported_by_provider)).order('updated_at desc') : []
    @my_ratings = Rating.where("rater_id = #{@user.id}").order('id desc')
  end

  def mydashboard
    if user_signed_in?
      redirect_to :action => :dashboard, :id => current_user.id
    else
      redirect_to(root_url, :alert => 'You must log in to access the dashboard.')
    end
  end

end
