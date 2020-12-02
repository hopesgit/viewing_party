require 'rails_helper'

describe "As a visitor" do
  describe 'When I visit /register' do
    before :each do
      visit '/register'
    end
    it 'I can register as a new user with a username, email and password' do
      expect(page).to have_field('user[username]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      fill_in 'user[username]', with: 'Joe'
      fill_in 'user[email]', with: 'Example@email.com'
      fill_in 'user[password]', with: 'Password'
      fill_in 'user[password_confirmation]', with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Welcome Joe")
    end
  end
end
