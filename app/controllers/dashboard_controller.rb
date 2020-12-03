class DashboardController < ApplicationController
  def show
    @friends = current_user.friends
  end
end
