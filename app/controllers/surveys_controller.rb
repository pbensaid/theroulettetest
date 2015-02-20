class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :results, :vote]

  def index
    @surveys = Survey.order(:name).page params[:page]
  end

  def show
    @sets_count = @survey.options.size/3
    @shuffled_options = @survey.options.shuffle
    @vote = Vote.new(params[:vote])
  end

  def new
    @survey = Survey.new
    3.times { @survey.options.build }
  end

  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to survey_path(@survey, mysecretcode: @survey.mysecretcode), notice: 'Your test was successfully created. Try it out!' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Your test was successfully updated' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Your test has been deleted.' }
      format.json { head :no_content }
    end
  end

  def vote
    @vote = Vote.new
    @vote.option_id = params[:option_id]
    @vote.save
  end

  def results
    respond_to do |format|
      format.json { render json: @survey_results, root: false }
      format.html
      format.js
    end
  end

  def showall
    @surveys = Survey.order(:name).page params[:page]
  end

  private
    def set_survey
      id = Hashids.new("three options good",5).decode(params[:id]).try(:first)
      @survey = Survey.find(id)
    end

    def survey_params
      params.require(:survey).permit(
        :name, :mysecretcode,
        options_attributes: [:id, :survey_id, :content, :votes_count, :_destroy,
        votes_attributes: [:id, :option_id, :_destroy]])
    end

end
