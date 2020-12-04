require "rails_helper"

describe MovieAPIService, type: :class do
  describe "instance methods" do
    before :each do
      @api = MovieAPIService.new
    end
    it 'conn' do
      expect(@api.conn.class).to eq(Faraday::Connection)
    end

    it 'get_top_rated_page_1', :vcr do
      expect(@api.get_top_rated_page_1.count).to eq(20)
      expect(@api.get_top_rated_page_1[0][:original_title]).to eq("Gabriel's Inferno Part III")
    end

    it 'get_top_rated_page_2', :vcr do
      expect(@api.get_top_rated_page_2.count).to eq(20)
      expect(@api.get_top_rated_page_2[0][:original_title]).to eq("Forrest Gump")
    end

    it 'get_top_rated', :vcr do
      expect(@api.get_top_rated.count).to eq(40)
    end
  end
end
