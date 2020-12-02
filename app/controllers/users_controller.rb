class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create!(user_params)
    flash[:success] = "You are now registered!"
    session[:user_id] = new_user.id
    redirect_to '/dashboard'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
