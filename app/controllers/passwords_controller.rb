class PasswordsController < ApplicationController
  before_action :find_user_have_token, only: %i(edit update)

  def new; end

  def create
    if params[:email].blank?
      flash[:notice] = "email not present" 
      redirect_to new_password_path
    end
    user = User.find_by_email(params[:email])
    if user.present?
      user.send_password_reset_instructions if user
      flash[:notice] = 'E-mail sent with password reset instructions.'
      redirect_to new_password_path
    else
      flash[:alert] = "Email address not found. Please check and try again."
      redirect_to new_password_path
    end
  end

  def edit; end

  def update
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:notice] = 'Password reset has expired'
      redirect_to new_password_path
    elsif @user.update(user_params)
      flash[:notice] = 'Password has been reset!'
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def find_user_have_token
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:password)
  end
end
