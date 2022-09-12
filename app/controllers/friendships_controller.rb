class FriendshipsController < ApplicationController
  before_action :find_friendship, only: %i(update destroy)

  def create
    current_user.friendships.create(friend_id: params[:user_id], confirmed: :false)
    flash[:notice] = 'Friend request sent.'
    redirect_to users_path
  end

  def update
    @friendship.update(confirmed: :true)
    redirect_to request.referrer
  end

  def destroy
    @friendship.destroy
    redirect_to request.referrer
  end

  private

  def find_friendship
    @friendship = Friendship.find_by(id: params[:id])
    unless @friendship.present?
      flash[:notice] = "friendship not found"
    end
  end
end
