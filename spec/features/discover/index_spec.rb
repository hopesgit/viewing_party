require "rails_helper"

describe "As a user" do
  describe "when I visit /discover" do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit discover_path
    end

    it "have a button to search for top-rated movies" do
      expect(page).to have_button("Find Top Rated Movies")
      expect(page).to have_content("OR")
    end

    it "when I click that button, it takes me to a results page" do
      click_button("Find Top Rated Movies")
      expect(current_path).to eq("/movies?q=top%20rated")
    end

    it "has a button and field to search for movies by name" do
      expect(page).to have_field(:movie_title_search)
      expect(page).to have_button("Find Movies")
    end
  end
end
