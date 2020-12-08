class EventsController < ApplicationController
  def new
    @movie = Movie.create!(movie_params)
    @event = Event.new
  end

  private

  def movie_params
    params.permit(:api_id, :runtime, :title)
  end
end
