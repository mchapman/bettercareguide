class OrganisationsController < ApplicationController

  load_and_authorize_resource

  # GET /organisations
  # GET /organisations.xml
  def index
    @organisations = Organisation.paginate :page => params[:page], :order => :name, :per_page => 12

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organisations }
    end
  end

  # GET /organisations/1
  # GET /organisations/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organisation }
    end
  end

  # GET /organisations/new
  # GET /organisations/new.xml
  def new
    @organisation.addresses << Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organisation }
    end
  end

  # GET /organisations/1/edit
  def edit
  end

  # POST /organisations
  # POST /organisations.xml
  def create
    @organisation.addresses << Address.new(params[:address])

    respond_to do |format|
      if @organisation.save
        format.html { redirect_to(@organisation, :notice => 'Organisation was successfully created.') }
        format.xml  { render :xml => @organisation, :status => :created, :location => @organisation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organisation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organisations/1
  # PUT /organisations/1.xml
  def update
    respond_to do |format|
      if @organisation.update_attributes(params[:organisation])
        format.html { redirect_to(@organisation, :notice => 'Organisation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organisation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.xml
  def destroy
    @organisation.destroy

    respond_to do |format|
      format.html { redirect_to(organisations_url) }
      format.xml  { head :ok }
    end
  end
end
