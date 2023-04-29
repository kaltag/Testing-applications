class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def autheticate_user!
    return if current_user

    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
