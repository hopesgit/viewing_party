class EventsController < ApplicationController
  def new
    binding.pry
    #@party = Event.new
    @movie = Movie.create(movie_params)
    @party = Event.new
  end

  def create
    require 'pry'; binding.pry
    redirect_to dashboard_path
  end

  private

  def movie_params
    params.permit(:api_id, :runtime, :title)
  end
  def event_params
    #params[:event].values[1..5].join("-").to_datetime
    #date = params[:event].values[1..3].join("-")
    #time = params[:event].values[4..5].join(":")
    #res = date + " " + time
    #res.to_datetime
    params.require(:event).permit(:user_id, :movie_id, :start_time, :duration)
  end

  def date_result
    date = event_params.values[0..2].join("-")
    time = event_params.values[3..4].join(":")
    res = date + " " + time
    res.to_datetime
  end
end
