class EventsController < ApplicationController
  def new
    @movie = Movie.find_or_create_by!(movie_params)
    @event = Event.new
  end

  private

  def movie_params
    params.permit(:api_id, :runtime, :title)
  end
end
