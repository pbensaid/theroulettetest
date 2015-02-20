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
    @vote = Vote.new(vote_params)
    @option = Option.find(@vote.option_id)
    @survey = Survey.find(@option.survey_id)
    @set_count = params[:set_count].to_i

    @vote.save
    respond_with @vote, survey: @survey, set_count: @set_count, layout: !request.xhr?
    @set_count += 1

    ## TO TIME BOX VOTING
    #uid = params[:vote][:user_id]
    #@extant = Vote.find(:last, :conditions => ["item_id = ? AND user_id = ?", item, uid])
    #last_vote_time = @extant.created_at unless @extant.blank?
    #curr_time = Time.now
    #if ((@extant && curr_time - last_vote_time >= 24.hours) || @extant.blank?)
    #...
    #else
    #  render :js =>  "alert('You may vote once every 24 hours for any one item.');"
    #end

  end

  private

    def vote_params
      params.require(:vote).permit(:id, :option_id, :set_count)
    end


end