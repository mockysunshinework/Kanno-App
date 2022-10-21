Rails.application.routes.draw do

  root "static_pages#top"
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

  resources :users, :only => [:index, :show, :destroy] do
    resources :tasks
  end
 
  # resources :users, :only => [:index, :show, :destroy] 
  # get '/users/:user_id/tasks/new', to: 'tasks#new'
  # post '/users/:user_id/tasks/create', to: 'tasks#create', as: :user_task_create
  # get '/users/:user_id/tasks', to: 'tasks#index', as: :user_tasks
  # get '/users/:user_id/tasks/:id', to: 'tasks#show', as: :user_task
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
