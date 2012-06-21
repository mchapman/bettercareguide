class InternalServiceTypesController < ApplicationController

  load_and_authorize_resource

  # GET /internal_service_types
  # GET /internal_service_types.xml
  def index
    @internal_service_types = InternalServiceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @internal_service_types }
    end
  end

  # GET /internal_service_types/1
  # GET /internal_service_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @internal_service_type }
    end
  end

  # GET /internal_service_types/new
  # GET /internal_service_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @internal_service_type }
    end
  end

  # GET /internal_service_types/1/edit
  def edit
  end

  # POST /internal_service_types
  # POST /internal_service_types.xml
  def create
    respond_to do |format|
      if @internal_service_type.save
        format.html { redirect_to(@internal_service_type, :notice => 'Internal service type was successfully created.') }
        format.xml  { render :xml => @internal_service_type, :status => :created, :location => @internal_service_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @internal_service_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /internal_service_types/1
  # PUT /internal_service_types/1.xml
  def update
    respond_to do |format|
      if @internal_service_type.update_attributes(params[:internal_service_type])
        format.html { redirect_to(@internal_service_type, :notice => 'Internal service type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @internal_service_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /internal_service_types/1
  # DELETE /internal_service_types/1.xml
  def destroy
    @internal_service_type.destroy

    respond_to do |format|
      format.html { redirect_to(internal_service_types_url) }
      format.xml  { head :ok }
    end
  end
end
