class Movie < ApplicationRecord
  validates :api_id, presence: true
  validates :api_id, uniqueness: true
  validates :runtime, presence: true
  validates :title, presence: true

  has_many :events
end
