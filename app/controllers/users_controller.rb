class UsersController < ApplicationController
  before_action :authenticate_user, only: %i(index show)
  before_action :find_user, only: %i(show edit)
  
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show; end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "you are signup succesfully"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private 

  def find_user
    @user = User.find_by(id: params[:id])
    unless @user.present?
      flash[:notice] = "user not found"
      redirect_to users_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end
