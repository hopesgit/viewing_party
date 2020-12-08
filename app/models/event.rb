class Event < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :user_id
  validates_presence_of :movie_id
  validates_presence_of :start_time
  validates_presence_of :duration
end
