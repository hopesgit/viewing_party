require 'rails_helper'

RSpec.describe "Events/New", type: :feature do
  describe 'As an authenticated user' do
    context 'when I visit events/new' do
      before do
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
        fill_in :duration, with: 190
        # select_datetime("2020, December, 20, 05 PM, 00", from: :start_time)
        # find(:css, "friend-#{@user2.id}").set(true)
      end
    end
  end
end
