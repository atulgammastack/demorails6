class LikesController < ApplicationController
  before_action :find_like

  def create
    @like = @post.likes.new(user_id: current_user.id)
    respond_to do |format|
      unless @like.save
        flash[:alert] = "You cannot like this post."
        redirect_back
      end
      @total_likes = @post.likes.count
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @like
        @like.destroy
      else
        flash[:alert] = "You cannot dislike post that you did not like before."
        redirect_back
      end
      @total_likes = @post.likes.count
      format.js
    end
  end

  private

  def find_like
    @post = Post.find_by(id: params[:post_id])
    @like = @post.like_by_user(current_user.id)
  end
end
