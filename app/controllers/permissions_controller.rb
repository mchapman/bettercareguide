class PermissionsController < ApplicationController

  load_and_authorize_resource

  def enter_codes
    # GET /permissions/enter_codes
    @permissions = Permission.outstanding_access_codes(current_user)
    case @permissions.count
    when 0
      redirect_to(root_url, :alert => 'No outstanding access codes.')
    when 1
      redirect_to (enter_code_path(@permissions.first))
    else
      @permissions = Permission.for_output(@permissions)
    end
  end

  # GET /permissions/1/edit
  def enter_code
  end

  # GET /permissions
  def index
    @permissions = Permission.order('coalesce(accepted,false), created_at desc').paginate(:page => params[:page], :per_page => 10)
  end

  # GET /permissions/1/process
  def process_code
    current_notes = @permission.notes ? @permission.notes + "\n" : ""
    if @permission.access_code.to_s == params[:access_code]
      @permission.accepted = true
      @permission.notes = current_notes + "\nCorrect access code entered #{Time.now.utc} from ip address #{current_user.current_sign_in_ip}"
      flash[:notice] = 'Access granted - you may now update the record'
    else
      @permission.code_failures = @permission.code_failures ? @permission.code_failures + 1 : 1
      @permission.notes = current_notes + "Failed attempt (#{params[:access_code]}) from ip address #{current_user.current_sign_in_ip} at #{Time.now.utc}"
      flash[:error] = 'Incorrect Access Code entered'
    end
    @permission.save!
    redirect_to(root_url)
  end

  # GET /permissions/1
  # GET /permissions/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
  end

  # PUT /permissions/1
  # PUT /permissions/1.xml
  def update
    respond_to do |format|
      if @permission.update_attributes(params[:perm])
        format.html { redirect_to(@permission, :notice => 'Permission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.xml
  def destroy
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(permissions_url) }
      format.xml  { head :ok }
    end
  end


end
