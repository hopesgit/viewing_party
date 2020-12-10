class DashboardController < ApplicationController
  def show
    api = MovieAPIService.new
    @friends = current_user.friends
    @upcoming_movies = api.upcoming_movies
  end
end
