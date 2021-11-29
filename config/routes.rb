Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create update destroy]
      resources :users, only: %i[index update]
      resources :favorites, only: %i[index create destroy]
      resources :comments, only: %i[index create destroy]
      resources :rates, only: %i[index create update]
      resources :hotpeppers, %i[create]
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
end
