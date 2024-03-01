Rails.application.routes.draw do
  resources :summary_translations
  resources :users
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post '/otp/verify', to: 'otp_verifications#verify_user_otp'
  get '/user_data', to: 'users#user_from_token'
  put '/user_data', to: 'users#update_user_from_token'
  post '/temp_user', to: 'users#create_temp_user'
  post '/upload_image', to: 'images#upload'
end
