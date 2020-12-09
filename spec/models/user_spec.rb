require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:inverse_friends).through(:inverse_friendships) }
    it { should have_many(:events) }
    it { should have_many(:participants) }
  end

  describe 'instance methods' do
    context '#events_invited_to' do
      before do
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

      it 'should return and array of events invited to' do
        expect(@user3.events_invited_to).to eq([@event1, @event2])
      end
    end
  end
end
