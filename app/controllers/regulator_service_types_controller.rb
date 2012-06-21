class RegulatorServiceTypesController < ApplicationController

  load_and_authorize_resource

  # GET /regulator_service_types
  # GET /regulator_service_types.xml
  def index
    @regulator_service_types = RegulatorServiceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @regulator_service_types }
    end
  end

  # GET /regulator_service_types/1
  # GET /regulator_service_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @regulator_service_type }
    end
  end

  # GET /regulator_service_types/new
  # GET /regulator_service_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @regulator_service_type }
    end
  end

  # GET /regulator_service_types/1/edit
  def edit
  end

  # POST /regulator_service_types
  # POST /regulator_service_types.xml
  def create
    respond_to do |format|
      if @regulator_service_type.save
        format.html { redirect_to(@regulator_service_type, :notice => 'Regulator service type was successfully created.') }
        format.xml  { render :xml => @regulator_service_type, :status => :created, :location => @regulator_service_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @regulator_service_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regulator_service_types/1
  # PUT /regulator_service_types/1.xml
  def update
    respond_to do |format|
      if @regulator_service_type.update_attributes(params[:regulator_service_type])
        format.html { redirect_to(@regulator_service_type, :notice => 'Regulator service type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @regulator_service_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regulator_service_types/1
  # DELETE /regulator_service_types/1.xml
  def destroy
    @regulator_service_type.destroy

    respond_to do |format|
      format.html { redirect_to(regulator_service_types_url) }
      format.xml  { head :ok }
    end
  end
end
