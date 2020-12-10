require 'rails_helper'

RSpec.describe "Events/New", type: :feature do
  describe 'As an authenticated user' do
    context 'when I visit events/new' do
      before :each do
        @user1 = User.create(username: 'John', email: 'Example@email.com', password: 'cool')
        @user2 = User.create!(username: 'jsmith', email: 'jsmith@example.com', password: 'password')
        @user3 = User.create!(username: 'tphill', email: 'tphill@example.com', password: 'password')
        @user4 = User.create!(username: 'crichards', email: 'crichards@example.com', password: 'password')

        Friendship.create!(user_id: @user1.id, friend_id: @user2.id)
        Friendship.create!(user_id: @user1.id, friend_id: @user3.id)
        Friendship.create!(user_id: @user1.id, friend_id: @user4.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

        visit movies_path
        click_on 'The Godfather'
        click_on 'Create Viewing Party for Movie'
      end

      it 'can create a new event', :vcr do
        fill_in "event[duration]", with: 190
        select("2022", from: "event[start_time(1i)]")
        select("May", from: "event[start_time(2i)]")
        select("3", from: "event[start_time(3i)]")
        select("05 PM", from: "event[start_time(4i)]")
        select("30", from: "event[start_time(5i)]")
        page.check('friend_id[]', option: @user2.id)
        page.check('friend_id[]', option: @user3.id)

        click_on "Create Event"
        expect(current_path).to eq(dashboard_path)

        within("#viewing-parties") do
          expect(page).to have_content("The Godfather")
          expect(page).to have_content("May 3, 2022, 5:30 PM")
        end
      end
    end
  end
end
