class Movie < ApplicationRecord
  validates_presence_of :api_id
  validates_uniqueness_of :api_id
  validates_presence_of :runtime
  validates_presence_of :title

  has_many :viewing_parties
end
