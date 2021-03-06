class EmploymentsController < ApplicationController

  load_and_authorize_resource

  # GET /employments
  # GET /employments.xml
  def index
    @employments = Employment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employments }
    end
  end

  # GET /employments/1
  # GET /employments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employment }
    end
  end

  # GET /employments/new
  # GET /employments/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employment }
    end
  end

  # GET /employments/1/edit
  def edit
  end

  # POST /employments
  # POST /employments.xml
  def create
    respond_to do |format|
      if @employment.save
        format.html { redirect_to(@employment, :notice => 'Employment was successfully created.') }
        format.xml  { render :xml => @employment, :status => :created, :location => @employment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employments/1
  # PUT /employments/1.xml
  def update
    respond_to do |format|
      if @employment.update_attributes(params[:employment])
        format.html { redirect_to(@employment, :notice => 'Employment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employments/1
  # DELETE /employments/1.xml
  def destroy
    @employment.destroy

    respond_to do |format|
      format.html { redirect_to(employments_url) }
      format.xml  { head :ok }
    end
  end
end
