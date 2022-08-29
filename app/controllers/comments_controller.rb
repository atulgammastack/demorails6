class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user
    if @comment.save
      flash[:success] = "comment was created succesfully"
      redirect_to posts_path
    else
      flash[:warn] = @comment.errors.full_messages.join('. ').to_s
      redirect_to posts_path
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
