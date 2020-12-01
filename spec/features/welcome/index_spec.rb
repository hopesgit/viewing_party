require "rails_helper"

describe "As a visitor" do
  before :each do
    visit "/"
  end
  describe "When I visit the root page" do
    it "I see the name of the site" do
      expect(page).to have_content("Welcome to Viewing Party")
    end

    it "I see a description of the site" do
      expect(page).to have_content("Your favorite destination for watching movies with friends! Register or sign in to get started.")
    end

    it "There's a form to log in" do
      fill_in("Email", with: "hope@example.com")
      fill_in("Password", with: "Password")
      expect(page).to have_field("Email", with: "hope@example.com" )
      expect(page).to have_field("Password", with: "Password")
      click_button "Sign In"

      expect(current_path).to eq("/dashboard")
    end

    it "There's a link to register" do
      expect(page).to have_link("New to Viewing Party? Register Here")

      click_link("New to Viewing Party? Register Here")
      expect(current_path).to eq("/register")
    end
  end
end
