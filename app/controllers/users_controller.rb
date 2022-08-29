class UsersController < ApplicationController
  before_action :require_login, only:[:index, :show]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user.present?
      flash[:notice] = "user not found"
      redirect_to users_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "you are signup succesfully"
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end
