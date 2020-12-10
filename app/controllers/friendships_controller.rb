class FriendshipsController < ApplicationController
  def create
    if User.find_by(email: params["Friend's Email"])
      @friend = User.find_by(email: params["Friend's Email"])
      Friendship.create([
                          { user_id: current_user.id, friend_id: @friend.id },
                          { user_id: @friend.id, friend_id: current_user.id }
                        ])
    else
      flash[:error] = 'User does not exist'
    end

    redirect_to dashboard_path
  end

  private

  def friend_param
    params.permit("Friend's Email")
  end
end
