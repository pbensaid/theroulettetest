class VotesController < ApplicationController
  respond_to :html, :js

  def index
  end

  def new
    @vote = Vote.new

    respond_to do |format|
      format.html new.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  def create
    @content = params[:commit]
    @sets_count = params[:sets_count].to_i
    @set_count = params[:set_count].to_i
    @vote = Vote.new(vote_params)
    @option = Option.find(@vote.option_id)
    @survey = Survey.find(@option.survey_id)
    @runoff = []
    @runoff << [:id, @vote.option_id]
    @runoff << [:content, params[:commit]]
    is_this_the_runoff

    @vote.save
    respond_with @vote, survey: @survey, set_count: @set_count, sets_count: @sets_count, runoff: @runoff, runoff_set: @runoff_set, layout: !request.xhr?
  end

  private

    def is_this_the_runoff
      if @set_count == @sets_count + 1
        @runoff_set = true
      else
        @runoff_set = false
      end
      puts "@runoff_set:'#{@runoff_set.inspect}'"
    end

    def vote_params
      params.require(:vote).permit(:id, :option_id, :set_count)
    end

end