Rails.application.routes.draw do
  # デフォルトだとログイン後はrootパスに飛ぶ。
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: "omniauth_callbacks"
  }
  root 'static_pages#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
