class OwnershipTypesController < ApplicationController

  load_and_authorize_resource

  # GET /ownership_types
  # GET /ownership_types.xml
  def index
    @ownership_types = OwnershipType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ownership_types }
    end
  end

  # GET /ownership_types/1
  # GET /ownership_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ownership_type }
    end
  end

  # GET /ownership_types/new
  # GET /ownership_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ownership_type }
    end
  end

  # GET /ownership_types/1/edit
  def edit
  end

  # POST /ownership_types
  # POST /ownership_types.xml
  def create
    respond_to do |format|
      if @ownership_type.save
        format.html { redirect_to(@ownership_type, :notice => 'Ownership type was successfully created.') }
        format.xml  { render :xml => @ownership_type, :status => :created, :location => @ownership_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ownership_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ownership_types/1
  # PUT /ownership_types/1.xml
  def update
    respond_to do |format|
      if @ownership_type.update_attributes(params[:ownership_type])
        format.html { redirect_to(@ownership_type, :notice => 'Ownership type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ownership_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ownership_types/1
  # DELETE /ownership_types/1.xml
  def destroy
    @ownership_type.destroy

    respond_to do |format|
      format.html { redirect_to(ownership_types_url) }
      format.xml  { head :ok }
    end
  end
end
