class Movie < ApplicationRecord
  validate_presence_of :api_key
  validate_uniqueness_of :api_key
  validate_presence_of :runtime
  validate_presence_of :title
end
