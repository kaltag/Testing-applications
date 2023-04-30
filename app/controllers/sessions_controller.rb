class SessionsController < ApplicationController
  skip_before_action :autheticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to(cookies.delete(:intended_url) || tests_path)
    else
      flash.now[:alert] = 'Verify email or password'
      render :new
    end
  end

  def destroy
    session.delete :user_id
    cookies.delete :intended_url
    redirect_to login_path, notice: 'Log out successful!'
  end
end
