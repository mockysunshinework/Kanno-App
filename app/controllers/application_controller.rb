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

  def current_user?(user)
    user == current_user
  end

  def correct_user
    unless current_user?(@user)
      flash[:danger] = "アクセスできません。"
      redirect_to root_url 
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "アクセス権限がありません。"
      redirect_to root_url
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :name]) # 注目
      devise_parameter_sanitizer.permit(:sign_up,keys:[:department, :partner])
      devise_parameter_sanitizer.permit(:account_update, keys: [:department, :partner])
    end

end
