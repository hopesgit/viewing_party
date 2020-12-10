require 'rails_helper'

describe 'As an authenticated User' do
  describe 'When I visit "/dashboard"' do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      @friend = User.create(username: 'Adam', email: 'Friend@email.com', password: '12345')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it 'Should have a message welcoming the User', :vcr do
      expect(page).to have_content("Welcome #{@user.username}")
    end

    it 'should have a button to discover movies', :vcr do
      expect(page).to have_button('Discover Movies')
      click_button('Discover Movies')

      expect(current_path).to eq('/discover')
    end

    it 'Has a friends section', :vcr do
      expect(page).to have_css('#friends')
    end

    it 'Has a Viewing Party section', :vcr do
      expect(page).to have_css('#viewing-parties')
    end
  end

  describe 'Dashboard upcoming movies' do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      @friend = User.create(username: 'Adam', email: 'Friend@email.com', password: '12345')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it 'Should display upcoming movies', :vcr do
      within(first('.upcoming-movies')) do
        expect(page).to have_css('.upcoming-movie-link')
      end
    end
  end


  describe 'Dashboard: Friends' do
    before :each do
      @user = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      @friend = User.create(username: 'Adam', email: 'Friend@email.com', password: '12345')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it 'There should be a text field to enter a friends email with button to "Add Friend"', :vcr do

      within '#friends' do
        expect(page).to have_field("Friend's Email")
        expect(page).to have_button("Add Friend")
      end

    end

    it "If there are no friends, .firends section should have message 'You Currently Have No Friends'", :vcr do

      within('#friends') do
        expect(page).to have_content("You currently have no Friends")
      end
    end

    it 'Should have a list of all friends', :vcr do

      within ('#friends') do
        fill_in "Friend's Email", with: @friend.email
        expect(page).to have_field("Friend's Email", with: @friend.email)
        click_button("Add Friend")

        within ("#friend-#{@friend.id}") do
          expect(page).to have_content(@friend.username)
        end
      end
    end

    it 'Should create a mutual friendship', :vcr do

      within ('#friends') do
        fill_in "Friend's Email", with: @friend.email
        expect(page).to have_field("Friend's Email", with: @friend.email)
        click_button("Add Friend")
      end

      expect(@user.friends).to eq([@friend])
      expect(@friend.friends).to eq([@user])
    end

    it "Can not add a User to Friends that doesn't exist", :vcr do

      within ('#friends') do
        fill_in "Friend's Email", with: "wrong@email.com"
        click_button("Add Friend")
      end
      expect(page).to have_content("User does not exist")
    end
  end

  describe 'User dashboard events' do
    before :each do
      @user1 = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
      @user2 = User.create!(username: 'jsmith', email: 'jsmith@example.com', password: 'password')
      @user3 = User.create!(username: 'tphill', email: 'tphill@example.com', password: 'password')
      @user4 = User.create!(username: 'crichards', email: 'crichards@example.com', password: 'password')

      Friendship.create!(user_id: @user1.id, friend_id: @user2.id)
      Friendship.create!(user_id: @user1.id, friend_id: @user3.id)
      Friendship.create!(user_id: @user1.id, friend_id: @user4.id)
      Friendship.create!(user_id: @user2.id, friend_id: @user1.id)
      Friendship.create!(user_id: @user2.id, friend_id: @user3.id)
      Friendship.create!(user_id: @user2.id, friend_id: @user4.id)

      @movie1 = Movie.create!(api_id: 1, title: 'The best movie', runtime: 175) 
      @movie2 = Movie.create!(api_id: 2, title: 'The worst movie', runtime: 120) 
      @movie3 = Movie.create!(api_id: 3, title: 'An ok movie', runtime: 125) 

      @event1 = Event.create!(user_id: @user1.id, movie_id: @movie1.id, start_time: DateTime.now, duration: 190)
      @event2 = Event.create!(user_id: @user2.id, movie_id: @movie2.id, start_time: DateTime.now, duration: 140)
      @event3 = Event.create!(user_id: @user3.id, movie_id: @movie3.id, start_time: DateTime.now, duration: 150)

      Participant.create!(user_id: @user2.id, event_id: @event1.id)
      Participant.create!(user_id: @user3.id, event_id: @event1.id)
      Participant.create!(user_id: @user4.id, event_id: @event1.id)
      Participant.create!(user_id: @user1.id, event_id: @event2.id)
      Participant.create!(user_id: @user3.id, event_id: @event2.id)
      Participant.create!(user_id: @user4.id, event_id: @event2.id)
      Participant.create!(user_id: @user1.id, event_id: @event3.id)
      Participant.create!(user_id: @user2.id, event_id: @event3.id)
      Participant.create!(user_id: @user4.id, event_id: @event3.id)
    end

    it 'Can see all events they are hosting', :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user3)
      visit dashboard_path
      
      within('#viewing-parties') do
        within(first('.hosting')) do
          expect(page).to have_content('An ok movie')
        end
      end
    end

    it 'Can see all events invited to', :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user3)
      visit dashboard_path

      within('#viewing-parties') do
        within('.invited-to') do
          expect(page).to have_content('The best movie')
          expect(page).to have_content('The worst movie')
        end
      end
    end
  end
end
