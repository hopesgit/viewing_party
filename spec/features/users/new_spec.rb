require 'rails_helper'

describe "As a visitor" do
  describe 'When I visit /register' do
    before :each do
      visit '/register'
    end
    it 'I can register as a new user with a username, email and password' do

      save_and_open_page
      expect(page).to have_field(:username)
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_field(:password_confirmation)
      fill_in :username, with: 'Joe'
      fill_in :email, with: 'Example@email.com'
      fill_in :password, with: 'Password'
      fill_in :password_confirmation, with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/dashboard')
      expace(page).to have_content("Welcome Joe")
    end
  end
end
