class RaterTypesController < ApplicationController

  load_and_authorize_resource

  # GET /rater_types
  # GET /rater_types.xml
  def index
    @rater_types = RaterType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rater_types }
    end
  end

  # GET /rater_types/1
  # GET /rater_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rater_type }
    end
  end

  # GET /rater_types/new
  # GET /rater_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rater_type }
    end
  end

  # GET /rater_types/1/edit
  def edit
  end

  # POST /rater_types
  # POST /rater_types.xml
  def create
    respond_to do |format|
      if @rater_type.save
        format.html { redirect_to(@rater_type, :notice => 'Rater type was successfully created.') }
        format.xml  { render :xml => @rater_type, :status => :created, :location => @rater_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rater_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rater_types/1
  # PUT /rater_types/1.xml
  def update
    respond_to do |format|
      if @rater_type.update_attributes(params[:rater_type])
        format.html { redirect_to(@rater_type, :notice => 'Rater type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rater_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rater_types/1
  # DELETE /rater_types/1.xml
  def destroy
    @rater_type.destroy

    respond_to do |format|
      format.html { redirect_to(rater_types_url) }
      format.xml  { head :ok }
    end
  end
end
