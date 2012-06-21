class RegulatorSectorTypesController < ApplicationController

  load_and_authorize_resource

  # GET /regulator_sector_types
  # GET /regulator_sector_types.xml
  def index
    @regulator_sector_types = RegulatorSectorType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @regulator_sector_types }
    end
  end

  # GET /regulator_sector_types/1
  # GET /regulator_sector_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @regulator_sector_type }
    end
  end

  # GET /regulator_sector_types/new
  # GET /regulator_sector_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @regulator_sector_type }
    end
  end

  # GET /regulator_sector_types/1/edit
  def edit
  end

  # POST /regulator_sector_types
  # POST /regulator_sector_types.xml
  def create
    respond_to do |format|
      if @regulator_sector_type.save
        format.html { redirect_to(@regulator_sector_type, :notice => 'Regulator sector type was successfully created.') }
        format.xml  { render :xml => @regulator_sector_type, :status => :created, :location => @regulator_sector_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @regulator_sector_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regulator_sector_types/1
  # PUT /regulator_sector_types/1.xml
  def update
    respond_to do |format|
      if @regulator_sector_type.update_attributes(params[:regulator_sector_type])
        format.html { redirect_to(@regulator_sector_type, :notice => 'Regulator sector type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @regulator_sector_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regulator_sector_types/1
  # DELETE /regulator_sector_types/1.xml
  def destroy
    @regulator_sector_type.destroy

    respond_to do |format|
      format.html { redirect_to(regulator_sector_types_url) }
      format.xml  { head :ok }
    end
  end
end
