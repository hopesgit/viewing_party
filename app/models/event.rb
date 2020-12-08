class Event < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :start_time, presence: true
  validates :duration, presence: true
end
