class PostsController < ApplicationController
  before_action :find_post, only: %i(edit show update)
  before_action :authenticate_user, only: %i( new index show)

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.recent
  end

  def show; end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Successfully created a new post."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "Successfully updated your post."
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id]) 
    @post.destroy
    flash[:success] = "You delted a post"
    redirect_to posts_path
  end

  private
  
  def post_params
    params.permit(:content, :post_file)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
    unless @post.present?
      flash[:notice] = "post not found"
      redirect_to posts_path
    end
  end
end
