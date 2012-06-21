class TownsController < ApplicationController

  load_and_authorize_resource

  # GET /towns
  # GET /towns.xml
  def index
    @towns = Town.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @towns }
    end
  end

  # GET /towns/1
  # GET /towns/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @town }
    end
  end

  # GET /towns/new
  # GET /towns/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @town }
    end
  end

  # GET /towns/1/edit
  def edit
  end

  # POST /towns
  # POST /towns.xml
  def create
    respond_to do |format|
      if @town.save
        format.html { redirect_to(@town, :notice => 'Town was successfully created.') }
        format.xml  { render :xml => @town, :status => :created, :location => @town }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @town.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /towns/1
  # PUT /towns/1.xml
  def update
    respond_to do |format|
      if @town.update_attributes(params[:town])
        format.html { redirect_to(@town, :notice => 'Town was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @town.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /towns/1
  # DELETE /towns/1.xml
  def destroy
    @town.destroy

    respond_to do |format|
      format.html { redirect_to(towns_url) }
      format.xml  { head :ok }
    end
  end
end
