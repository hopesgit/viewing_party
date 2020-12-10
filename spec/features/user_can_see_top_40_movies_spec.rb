require 'rails_helper'

RSpec.describe "User can see top 40 movies", type: :feature do
  before do
    @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path
  end

  scenario "When a user visit's /movies" do
    VCR.use_cassette('top_rated_40_search') do
      click_on 'Find Top Rated Movies'
      expect(page).to have_current_path(movies_path)

      within(first(".movie")) do
        expect(page).to have_css(".title")
        expect(page).to have_css(".rating")
      end
    end
  end
end
