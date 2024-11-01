# Rails.application.routes.draw do
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Defines the root path route ("/")
#   # root "posts#index"
# end
Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'

  get '/login', to: 'sessions#new', as: 'new_session'
  resource :session, only: %i[create destroy]

  get '/forgot_password', to: 'password_resets#new', as: 'new_password_reset'
  get '/reset_password', to: 'password_resets#edit', as: 'edit_password_reset'
  resource :password_reset, only: %i[create update]

  resource :email_confirmation, only: %i[create]
  get '/email_confirmation', to: 'email_confirmations#update'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create', as: 'users'

  patch '/profile/change_password', to: 'passwords#update', as: 'user_password_change'
  put '/profile/change_password', to: 'passwords#update'

  resources :secret_groups, only: %i[new edit create update destroy], param: :name do
    resources :secrets, only: :new
  end

  resources :secrets, only: %i[index create edit update destroy]

  get '/profile/edit', to: 'users#edit', as: 'edit_user_profile'
  patch '/profile/edit', to: 'users#update'
  put '/profile/edit', to: 'users#update'
  post '/user_search', to: 'users#search', as: 'user_search'
  get '/profile', to: 'users#profile', as: 'user_profile'
  delete '/profile', to: 'users#destroy'
end
