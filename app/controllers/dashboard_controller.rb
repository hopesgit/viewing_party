class DashboardController < ApplicationController
  # before_action :require_user

  def show
    @user = User.find(session[:user_id])
  end

  # private
  # def require_user
  #
  # end
end
