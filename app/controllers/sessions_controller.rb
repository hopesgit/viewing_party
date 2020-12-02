class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully."
      redirect_to dashboard_path
    else
      flash[:error] = "Email or Password doesn't match our records."
      redirect_to root_path
    end
  end
end
