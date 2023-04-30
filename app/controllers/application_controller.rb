class ApplicationController < ActionController::Base
  before_action :autheticate_user!

  helper_method :current_user,
                :logged_in?

  private

  def autheticate_user!
    return if current_user

    cookies[:intended_url] = request.url
    redirect_to login_path, alert: 'Verify email or password'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
