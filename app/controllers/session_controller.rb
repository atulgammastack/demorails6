class SessionController < ApplicationController
  def new; end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:alert] = "login succesfully"
      redirect_to posts_path
    else
      flash[:error]= "invalid email or password"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "logged out "
    redirect_to root_path
  end
end
