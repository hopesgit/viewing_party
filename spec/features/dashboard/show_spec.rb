require 'rails_helper'

describe 'As an authenticated User' do
  describe 'When i visit "/dashboard"' do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      @friend = User.create(username: 'Adam', email: 'Friend@email.com', password: '12345')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      #@movie
      #@party = ViewingParty.create(host: #@user.id, guest: [@friend.id], movie: #@movie[:title])
      visit dashboard_path
    end

    it 'Should have a message welcoming the User' do
      expect(page).to have_content("Welcome #{@user.username}")
    end

    it 'should have a button to discover movies' do
      expect(page).to have_button('Discover Movies')
      click_button('Discover Movies')

      expect(current_path).to eq('/discover')
    end

    it 'Has a friends section' do
      expect(page).to have_css('#friends')
      #within '#friends' do
      #  expect(page).to have_content(@friend.name)
      #end
    end

    it 'Has a Viewing Party section' do
      expect(page).to have_css('#viewing-parties')
      #within '#viewing-parties' do
      #  expect(page).to have_content(@party.name)
      #end
    end
  end
end
