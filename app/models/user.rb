class User < ApplicationRecord
  has_many :friendships, dependent: :delete_all
  has_many :friends, through: :friendships, dependent: :delete_all
  has_many :events, dependent: :delete_all
  has_many :participants, dependent: :delete_all

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_secure_password

  def events_invited_to
    participants.map do |participant|
      Event.find(participant.event_id)
    end
  end
end
