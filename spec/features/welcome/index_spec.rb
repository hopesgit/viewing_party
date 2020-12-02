require "rails_helper"

describe "As a visitor" do
  before :each do
    visit root_path
  end
  describe "When I visit the root page" do
    it "I see the name of the site" do
      expect(page).to have_content("Welcome to Viewing Party")
    end

    it "I see a description of the site" do
      expect(page).to have_content("Your favorite destination for watching movies with friends! Register or sign in to get started.")
    end

    it "There's a link to register" do
      expect(page).to have_link("New to Viewing Party? Register Here")

      click_link("New to Viewing Party? Register Here")
      expect(current_path).to eq("/register")
    end

    before :each do
      @user1 = User.create!(username: "hopegochnour", email: "hope@example.com", password: "Password")
    end

    it "There's a form to log in" do
      fill_in("Email", with: "hope@example.com")
      fill_in("Password", with: "Password")
      expect(page).to have_field("Email", with: "hope@example.com" )
      expect(page).to have_field("Password", with: "Password")
      click_button "Sign In"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Logged in successfully.")
      expect(page).to have_content("Welcome #{@user1.username}")
    end

    it "Can't log in with bad credentials" do
      fill_in("Email", with: "#{@user1.email}")
      fill_in("Password", with: "0")

      click_button "Sign In"

      expect(current_path).to_not eq("/dashboard")
      expect(page).to have_content("Email or Password doesn't match our records.")
    end
  end
end
