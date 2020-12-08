require "rails_helper"

describe Movie, type: :model do
  describe "relationships" do
    # blah
  end

  describe "validations" do
    it {should validate_uniqueness_of :api_id}
    it {should validate_presence_of :api_id}
    it {should validate_presence_of :runtime}
    it {should validate_presence_of :title}
  end

  describe "instance methods" do
    # blah
  end
end
