class MovieAPIService
  def conn
    Faraday.new(
      url: "https://api.themoviedb.org/3/movie",
      params: {api_key: ENV['tmdb_api_key']}
    )
  end

  def get_top_rated_page_1
    response1 = conn.get('top_rated') do |c|
      c.params["page"] = 1
    end
    JSON.parse(response1.body, symbolize_names: true)[:results]
  end

  def get_top_rated_page_2
    response2 = conn.get('top_rated') do |c|
      c.params["page"] = 2
    end
    JSON.parse(response2.body, symbolize_names: true)[:results]
  end

  def get_top_rated
    top_movies = []
    top_movies << get_top_rated_page_1
    top_movies << get_top_rated_page_2
    top_movies.flatten
  end
end
