class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:user_id], confirmed: false)
    flash[:notice] = 'Friend request sent.'
    redirect_to users_path
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.update(confirmed: true)
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    redirect_to users_path
  end
end
