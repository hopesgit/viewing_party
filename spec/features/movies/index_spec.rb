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
      # within(first(".movie")) do
      #   within(".title") do
      #     expect(page).to have_content("Gabriel's Inferno Part III")
      #   end
      # end

      fill_in(:movie_title, with: "down")
      click_button("Find Movies")

      within(first(".movie")) do
        within(".title") do
          expect(page).to_not have_content("Gabriel's Inferno Part III")
        end
      end
    end
  end
end
