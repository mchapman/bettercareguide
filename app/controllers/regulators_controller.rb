class RegulatorsController < ApplicationController

  load_and_authorize_resource

  # GET /regulators
  # GET /regulators.xml
  def index
    @regulators = Regulator.order(:obsolete)
    counts = Service.joins(:regulator).where('services.deregistration_date is null and services.internal_service_type_id in (1,2,4)').select('regulators.id').group('regulators.id').order('regulators.id').count
    @regulators.each {|r| r.registration_count=counts[r.id]}
  end

  # GET /regulators/1
  # GET /regulators/1.xml
  def show
  end

  # GET /regulators/new
  # GET /regulators/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @regulator }
    end
  end

  # GET /regulators/1/edit
  def edit
    @types = InternalServiceType.order(:sort_order)
    counts = Service.where('deregistration_date is null and regulator_id = ?',@regulator.id).select('internal_service_type_id').group('internal_service_type_id').order('internal_service_type_id').count
    @types.each {|t| t.type_count = counts[t.id]}
  end

  # POST /regulators
  # POST /regulators.xml
  def create
    respond_to do |format|
      if @regulator.save
        format.html { redirect_to(@regulator, :notice => 'Regulator was successfully created.') }
        format.xml  { render :xml => @regulator, :status => :created, :location => @regulator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @regulator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regulators/1
  # PUT /regulators/1.xml
  def update
    respond_to do |format|
      if @regulator.update_attributes(params[:regulator])
        format.html { redirect_to(@regulator, :notice => 'Regulator was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @regulator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regulators/1
  # DELETE /regulators/1.xml
  def destroy
    @regulator.destroy

    respond_to do |format|
      format.html { redirect_to(regulators_url) }
      format.xml  { head :ok }
    end
  end

end
