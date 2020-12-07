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

      expect(page).to have_button("Create Viewing Party for Movie")
    end

    it "Has movie details: Title, Vote ANG, Runtime, Genere's, Summary, first 10 cast members, Review count w author and info.", :vcr do
      click_on 'The Godfather'
      
      expect(page).to have_content("The Godfather")

      within('.general-information') do
        expect(page).to have_content("")
        expect(page).to have_content("")
        expect(page).to have_content("")
      end
    end
  end
end
