class MoviesController < ApplicationController
  def index
    conn = Faraday.new(
      url: "https://api.themoviedb.org/3/movie",
      params: {api_key: ENV['tmdb_api_key']})

    response1 = conn.get('top_rated') do |c|
      c.params["page"] = 1
    end
    response2 = conn.get('top_rated') do |c|
      c.params["page"] = 2
    end

    movies_page_1 = JSON.parse(response1.body, symbolize_names: true)[:results]
    movies_page_2 = JSON.parse(response2.body, symbolize_names: true)[:results]

    top_movies = []
    top_movies << movies_page_1
    top_movies << movies_page_2
    @list_of_top_movies = top_movies.flatten
  end
end
