class OwnershipsController < ApplicationController

  load_and_authorize_resource

  # GET /ownerships
  # GET /ownerships.xml
  def index
    @ownerships = Ownership.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ownerships }
    end
  end

  # GET /ownerships/1
  # GET /ownerships/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ownership }
    end
  end

  # GET /ownerships/new
  # GET /ownerships/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ownership }
    end
  end

  # GET /ownerships/1/edit
  def edit
  end

  # POST /ownerships
  # POST /ownerships.xml
  def create
    respond_to do |format|
      if @ownership.save
        format.html { redirect_to(@ownership, :notice => 'Ownership was successfully created.') }
        format.xml  { render :xml => @ownership, :status => :created, :location => @ownership }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ownership.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ownerships/1
  # PUT /ownerships/1.xml
  def update
    respond_to do |format|
      if @ownership.update_attributes(params[:ownership])
        format.html { redirect_to(@ownership, :notice => 'Ownership was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ownership.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ownerships/1
  # DELETE /ownerships/1.xml
  def destroy
    @ownership.destroy

    respond_to do |format|
      format.html { redirect_to(ownerships_url) }
      format.xml  { head :ok }
    end
  end
end
