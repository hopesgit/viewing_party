require 'rails_helper'

describe 'As an authenticated User' do
  before :each do
    @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
    @friend = User.create(username: 'Adam', email: 'Friend@email.com', password: '12345')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    #@movie = ?
    #@party = ViewingParty.create(host: #@user.id, guest: [@friend.id], movie: #@movie[:title])
    visit dashboard_path
  end
  describe 'When I visit "/dashboard"' do

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
    end

    it 'Has a Viewing Party section' do
      expect(page).to have_css('#viewing-parties')
    end
  end

  describe 'Dashboard: Friends' do

    it 'There should be a text field to enter a friends email with button to "Add Friend"' do

      within '#friends' do
        expect(page).to have_field("Friend's Email")
        expect(page).to have_button("Add Friend")
      end

    end

    it "If there are no friends, .firends section should have message 'You Currently Have No Friends'" do

      within('#friends') do
        expect(page).to have_content("You currently have no Friends")
      end
    end

    it 'Should have a list of all friends' do

      within ('#friends') do
        fill_in "Friend's Email", with: @friend.email
        expect(page).to have_field("Friend's Email", with: @friend.email)
        click_button("Add Friend")

        within ("#friend-#{@friend.id}") do
          expect(page).to have_content(@friend.username)
        end
      end
    end

    it 'Should create a mutual friendship' do

      within ('#friends') do
        fill_in "Friend's Email", with: @friend.email
        expect(page).to have_field("Friend's Email", with: @friend.email)
        click_button("Add Friend")
      end

      expect(@user.friends).to eq([@friend])
      expect(@friend.friends).to eq([@user])
    end

    it "Can not add a User to Friends that doesn't exist" do

      within ('#friends') do
        fill_in "Friend's Email", with: "wrong@email.com"
        click_button("Add Friend")
      end
      expect(page).to have_content("User does not exist")
    end
  end

  describe "Dashboard: Discover Movies" do

  end
end
