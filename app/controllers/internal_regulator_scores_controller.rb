class InternalRegulatorScoresController < ApplicationController

  load_and_authorize_resource

  # GET /internal_regulator_scores
  # GET /internal_regulator_scores.xml
  def index
    @internal_regulator_scores = InternalRegulatorScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @internal_regulator_scores }
    end
  end

  # GET /internal_regulator_scores/1
  # GET /internal_regulator_scores/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @internal_regulator_score }
    end
  end

  # GET /internal_regulator_scores/new
  # GET /internal_regulator_scores/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @internal_regulator_score }
    end
  end

  # GET /internal_regulator_scores/1/edit
  def edit
  end

  # POST /internal_regulator_scores
  # POST /internal_regulator_scores.xml
  def create

    respond_to do |format|
      if @internal_regulator_score.save
        format.html { redirect_to(@internal_regulator_score, :notice => 'Internal regulator score was successfully created.') }
        format.xml  { render :xml => @internal_regulator_score, :status => :created, :location => @internal_regulator_score }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @internal_regulator_score.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /internal_regulator_scores/1
  # PUT /internal_regulator_scores/1.xml
  def update
    respond_to do |format|
      if @internal_regulator_score.update_attributes(params[:internal_regulator_score])
        format.html { redirect_to(@internal_regulator_score, :notice => 'Internal regulator score was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @internal_regulator_score.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /internal_regulator_scores/1
  # DELETE /internal_regulator_scores/1.xml
  def destroy
    @internal_regulator_score.destroy

    respond_to do |format|
      format.html { redirect_to(internal_regulator_scores_url) }
      format.xml  { head :ok }
    end
  end
end
