require 'rails_helper'

describe "As a user" do
  describe "when I visit /movies" do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/movies"
    end

    it "displays a list of movies and their vote averages", :vcr do
      within(first(".movie")) do
        expect(page).to have_css(".title")
        expect(page).to have_css(".rating")
      end

      expect(page).to have_css(".movie", count: 40)
    end

    it "has a field to type in a title and search by that", :vcr do
      VCR.use_cassette("top_rated_40_search") do
        VCR.use_cassette("search_movies_by_keyword_search") do
          within(first(".movie")) do
            within(".title") do
              expect(page).to have_content("Gabriel's Inferno Part III")
            end
          end

          fill_in(:movie_title, with: "down")
          click_button("Find Movies")

          within(first(".movie")) do
            within(".title") do
              expect(page).to have_content("Upside-Down Magic")
            end
          end
        end
      end
    end

    it "Each Title is a link to that movies detail page", :vcr do
      within(first(".movie")) do
        click_link("Gabriel's Inferno Part III")
      end
      expect(current_path).to eq('/movies/761053')
    end
  end
end
