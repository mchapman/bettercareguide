class PhoneTypesController < ApplicationController

  load_and_authorize_resource

  # GET /phone_types
  # GET /phone_types.xml
  def index
    @phone_types = PhoneType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phone_types }
    end
  end

  # GET /phone_types/1
  # GET /phone_types/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phone_type }
    end
  end

  # GET /phone_types/new
  # GET /phone_types/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_type }
    end
  end

  # GET /phone_types/1/edit
  def edit
  end

  # POST /phone_types
  # POST /phone_types.xml
  def create
    respond_to do |format|
      if @phone_type.save
        format.html { redirect_to(@phone_type, :notice => 'Phone type was successfully created.') }
        format.xml  { render :xml => @phone_type, :status => :created, :location => @phone_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phone_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phone_types/1
  # PUT /phone_types/1.xml
  def update
    respond_to do |format|
      if @phone_type.update_attributes(params[:phone_type])
        format.html { redirect_to(@phone_type, :notice => 'Phone type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phone_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_types/1
  # DELETE /phone_types/1.xml
  def destroy
    @phone_type.destroy

    respond_to do |format|
      format.html { redirect_to(phone_types_url) }
      format.xml  { head :ok }
    end
  end
end
