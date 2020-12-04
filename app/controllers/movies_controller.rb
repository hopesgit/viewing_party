class MoviesController < ApplicationController
  def index
    @movies = MovieAPIService.new.get_top_rated
  end
end
