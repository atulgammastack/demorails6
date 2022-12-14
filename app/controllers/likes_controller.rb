class LikesController < ApplicationController
  before_action :find_like
  
  def create
    @like = @post.likes.new(user_id: current_user.id)
    if @like.save
      flash[:success] = "You liked a post."
      redirect_to request.referrer
    else
      flash[:alert] = "You cannot like this post."
      redirect_back
    end
  end

  def destroy
    if @like
      @like.destroy
      flash[:notice] = "You disliked a post."
      redirect_to request.referrer
    else
      flash[:alert] = "You cannot dislike post that you did not like before."
      redirect_back
    end
  end
  
  private

  def find_like
    @post = Post.find(params[:post_id])
    @like = @post.like_by_user(current_user.id)
  end
end
