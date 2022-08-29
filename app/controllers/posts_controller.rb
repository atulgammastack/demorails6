class PostsController < ApplicationController
  before_action :find_post, only: [:edit,:show,:update]
  before_action :require_login, only:[:new,:index,:show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.ordered_by_most_recent
  end

  def show; end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "post was succesfully uploaded"
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  private
  
  def post_params
    params.permit(:content)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
    unless @post.present?
      flash[:notice] = "post not found"
      redirect_to posts_path
    end
  end
end
