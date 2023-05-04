class Users::SessionsController < Devise::SessionsController
  after_action :custom_welcome, only: [:create]

  def custom_welcome
    flash.notice = t('.hello', greeting: current_user.first_name) if flash.key?(:notice)
  end
end
