class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private

  def authenticate_user
    unless current_user.present?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end
end
