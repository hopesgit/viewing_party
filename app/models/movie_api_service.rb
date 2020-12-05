class MovieAPIService
  def conn
    Faraday.new(
      url: "https://api.themoviedb.org/3/",
      params: {api_key: ENV['tmdb_api_key']}
    )
  end

  def get_top_rated_page(page_number)
    response = conn.get('movie/top_rated') do |c|
      c.params["page"] = page_number
    end
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def get_top_rated
    top_movies = []
    top_movies << get_top_rated_page(1)
    top_movies << get_top_rated_page(2)
    top_movies.flatten
  end

  def find_movies_by_title(search, page_number)
    response = conn.get('search/movie') do |c|
      c.params["page"] = page_number
      c.params["query"] = search
    end
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def search_movies_by_keyword(search)
    movies_from_search = []
    movies_from_search << find_movies_by_title(search, 1)
    movies_from_search << find_movies_by_title(search, 2)
    movies_from_search.flatten
  end
end
