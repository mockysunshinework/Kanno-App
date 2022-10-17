Rails.application.routes.draw do

  # デフォルトだとログイン後はrootパスに飛ぶ。
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: "omniauth_callbacks"
  }
  root to: 'static_pages#top' 


  # devise_scope :user do
    # TIPS: ユーザー登録しっぱいのリダイレクトのエラーを防ぐ https://github.com/heartcombo/devise/blob/master/app/controllers/devise/registrations_controller.rb
    # get '/users', to: 'users/registrations#new'
    # or
    # get '/users', to: redirect('/users/sign_up')
  # end

  resources :users, :only => [:index, :show, :destroy]

 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
