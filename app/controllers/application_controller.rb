class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:index, :show] 
  before_action :configure_permitted_parameters, if: :devise_controller? 

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def admin_user?
    current_user.admin?
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :name]) # 注目
    end

end
