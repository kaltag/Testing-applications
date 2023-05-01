class ApplicationController < ActionController::Base
  def after_sign_in_path_for(current_user)
    if current_user.type == 'Admin'
      admin_tests_path
    else
      root_path
    end
  end
end
