require "rails_helper"

describe "As a User" do
  describe "When I visit /movies/:id" do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit movies_path
    end

    it "Has a button to create a viewing party", :vcr do
      click_on 'The Godfather'

      click_on 'Create Viewing Party for Movie'
      expect(page).to have_current_path(events_new_path)
    end

    it "Has movie details: Title, Vote ANG, Runtime, Genere's, Summary, first 10 cast members, Review count w author and info.", :vcr do
      click_on 'The Godfather'
      
      expect(page).to have_content("The Godfather")

      within('.general-information') do
        expect(page).to have_content("8.7")
        expect(page).to have_content("175")
        expect(page).to have_content("Drama Crime")
      end

      within('.summary') do
        expect(page).to have_css('#movie-summary')
      end

      within('.cast') do
        expect(page).to have_css('#cast-member', count: 10) 
      end

      within('.reviews') do
        expect(page).to have_css('.review-author') 
        expect(page).to have_css('.review-content') 
      end
    end
  end
end
