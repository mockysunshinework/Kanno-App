# ApplicationController を Devise::OmniauthCallbacksController に変更
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # 以下を追加
  def line; basic_action
  end

  private
  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      sign_in(:user, @profile)
    end
    
    if @profile.department.blank?
      flash[:notice] = "所属IDを設定して下さい。所属ID未設定のままではリクエスト機能が利用できません。"
      redirect_to edit_user_registration_path   
    else
      flash[:notice] = "ログインしました"
      redirect_to root_path
    end
  end

  def fake_email(uid, provider)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
  # 以上を追加
end
