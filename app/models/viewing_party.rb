class ViewingParty < ApplicationRecord
  belongs_to :movie, :user
  validates_presence_of :user_id
  validates_presence_of :movie_id
  validates_presence_of :start_time
  validates_presence_of :duration
end
