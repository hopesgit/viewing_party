require "rails_helper"

describe MovieAPIService, type: :class do
  describe "instance methods" do
    before :each do
      @api = MovieAPIService.new
    end
    it 'conn' do
      expect(@api.conn.class).to eq(Faraday::Connection)
    end

    it 'get_top_rated_page(page_number)', :vcr do
      expect(@api.top_rated_page(1).count).to eq(20)
      expect(@api.top_rated_page(1)[0][:original_title]).to eq("Gabriel's Inferno Part III")
    end

    it 'get_top_rated', :vcr do
      expect(@api.top_rated.count).to eq(40)
    end

    it 'find_movies_by_title(search, page_number)', :vcr do
      expect(@api.find_movies_by_title("blue", 1).count).to eq(20)
      expect(@api.find_movies_by_title("blue", 1)[0][:original_title]).to eq("Black and Blue")
    end

    it 'search_movies_by_keyword(search)', :vcr do
      expect(@api.search_movies_by_keyword("blue").count).to eq(40)
    end
  end
end
