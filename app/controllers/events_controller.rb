class EventsController < ApplicationController
  def new
    @movie = Movie.find_or_create_by!(movie_params)
    binding.pry
  end

  def create
    @movie = Movie.first
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
    date = event_params.values[1..3].join("-")
    time = event_params.values[4..5].join(":")
    res = date + " " + time
    res.to_datetime
  end
end
