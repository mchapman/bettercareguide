class InternalSectorTypesController < ApplicationController

  load_and_authorize_resource

  # GET /internal_sector_types
  # GET /internal_sector_types.xml
  def index
    @internal_sector_types = InternalSectorType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @internal_sector_types }
    end
  end

  # GET /internal_sector_types/1
  # GET /internal_sector_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @internal_sector_type }
    end
  end

  # GET /internal_sector_types/new
  # GET /internal_sector_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @internal_sector_type }
    end
  end

  # GET /internal_sector_types/1/edit
  def edit
  end

  # POST /internal_sector_types
  # POST /internal_sector_types.xml
  def create
    respond_to do |format|
      if @internal_sector_type.save
        format.html { redirect_to(@internal_sector_type, :notice => 'Internal sector type was successfully created.') }
        format.xml  { render :xml => @internal_sector_type, :status => :created, :location => @internal_sector_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @internal_sector_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /internal_sector_types/1
  # PUT /internal_sector_types/1.xml
  def update
    respond_to do |format|
      if @internal_sector_type.update_attributes(params[:internal_sector_type])
        format.html { redirect_to(@internal_sector_type, :notice => 'Internal sector type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @internal_sector_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /internal_sector_types/1
  # DELETE /internal_sector_types/1.xml
  def destroy
    @internal_sector_type.destroy

    respond_to do |format|
      format.html { redirect_to(internal_sector_types_url) }
      format.xml  { head :ok }
    end
  end
end
