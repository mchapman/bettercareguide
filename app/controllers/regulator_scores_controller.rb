class RegulatorScoresController < ApplicationController

  load_and_authorize_resource

  # GET /regulator_scores
  # GET /regulator_scores.xml
  def index
    @regulator_scores = RegulatorScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @regulator_scores }
    end
  end

  # GET /regulator_scores/1
  # GET /regulator_scores/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @regulator_score }
    end
  end

  # GET /regulator_scores/new
  # GET /regulator_scores/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @regulator_score }
    end
  end

  # GET /regulator_scores/1/edit
  def edit
  end

  # POST /regulator_scores
  # POST /regulator_scores.xml
  def create
    respond_to do |format|
      if @regulator_score.save
        format.html { redirect_to(@regulator_score, :notice => 'Regulator score was successfully created.') }
        format.xml  { render :xml => @regulator_score, :status => :created, :location => @regulator_score }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @regulator_score.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regulator_scores/1
  # PUT /regulator_scores/1.xml
  def update
    respond_to do |format|
      if @regulator_score.update_attributes(params[:regulator_score])
        format.html { redirect_to(@regulator_score, :notice => 'Regulator score was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @regulator_score.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regulator_scores/1
  # DELETE /regulator_scores/1.xml
  def destroy
    @regulator_score.destroy

    respond_to do |format|
      format.html { redirect_to(regulator_scores_url) }
      format.xml  { head :ok }
    end
  end
end
