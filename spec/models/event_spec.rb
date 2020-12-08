require "rails_helper"

RSpec.describe Event, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :movie }
  end

  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :duration }
  end

  describe "instance methods" do
    # blah
  end
end
