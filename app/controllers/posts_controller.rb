class PostsController < ApplicationController
  before_action :find_post, only: %i[edit show update]
  before_action :authenticate_user, only: %i[new index show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.recent_posts
  end

  def show; end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "your post was succesfully uploaded."
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "your post was successfully updated."
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
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
