class ViewingPartyController < ApplicationController
  def new
    binding.pry
    Movie.new
  end
end
