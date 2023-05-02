class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(current_user)
    if current_user.admin?
      admin_tests_path
    else
      root_path
    end
  end
end
