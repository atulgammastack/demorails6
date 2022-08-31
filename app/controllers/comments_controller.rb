class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params.merge(post_id: params[:post_id]))
    if @comment.save
      flash[:success] = "your comment was submitted"
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
