require 'rails_helper'

describe "As a visitor" do
  describe 'When I visit /register' do
    before :each do
      visit '/register'
    end

    it 'has a link for previously registered users to login' do
      click_link 'Already Registered? Log in Here'
      expect(page).to have_current_path('/')
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

    it 'Passwords must match' do
      fill_in 'user[username]', with: 'Joe'
      fill_in 'user[email]', with: 'Example@email.com'
      fill_in 'user[password]', with: 'Password'
      fill_in 'user[password_confirmation]', with: 'PasswordXYZ123'

      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'usernname can not be blank' do
      fill_in 'user[username]', with: ''
      fill_in 'user[email]', with: 'Example@email.com'
      fill_in 'user[password]', with: 'Password'
      fill_in 'user[password_confirmation]', with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Username can't be blank")
    end

    it 'email can not be blank' do
      fill_in 'user[username]', with: 'Joe'
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: 'Password'
      fill_in 'user[password_confirmation]', with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email can't be blank")
    end

    it 'password can not be blank' do
      fill_in 'user[username]', with: 'Joe'
      fill_in 'user[email]', with: 'Example@email.com'
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Password can't be blank")
    end

   it 'usernname must be unique' do
      User.create(username: 'Joe', email: 'hi@example.com', password: 'cool')

      fill_in 'user[username]', with: 'Joe'
      fill_in 'user[email]', with: 'Example@email.com'
      fill_in 'user[password]', with: 'Password'
      fill_in 'user[password_confirmation]', with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content('Username has already been taken')
    end

  it 'usernname must be unique' do
      User.create(username: 'John', email: 'Example@email.com', password: 'cool')

      fill_in 'user[username]', with: 'Joe'
      fill_in 'user[email]', with: 'Example@email.com'
      fill_in 'user[password]', with: 'Password'
      fill_in 'user[password_confirmation]', with: 'Password'

      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content('Email has already been taken')
    end
  end
end
