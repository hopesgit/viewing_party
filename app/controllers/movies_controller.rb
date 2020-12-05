class MoviesController < ApplicationController
  def index
    api = MovieAPIService.new
    if !params["movie_title"].nil?
      @movies = api.search_movies_by_keyword(params[:movie_title])
    else
      @movies = api.get_top_rated
    end
  end

  def show
    api = MovieAPIService.new
    @movie = api.movie_details(params[:id])
    @cast = api.movie_cast(params[:id])
    @reviews = api.movie_reviews(params[:id])
  end
end
