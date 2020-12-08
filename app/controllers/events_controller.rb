class EventsController < ApplicationController
  def new
    @movie = Movie.find_or_create_by!(movie_params)
    @event = @movie.events.new
  end

  def create
require 'pry'; binding.pry
  end

  private

  def movie_params
    params.permit(:api_id, :runtime, :title)
  end
end
