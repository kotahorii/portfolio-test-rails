Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/posts/fav_sort', to: 'posts#fav_sort'
      get '/posts/rate_sort', to: 'posts#rate_sort'
      get '/posts/rate_ave', to: 'posts#rate_ave'
      resources :posts, only: %i[index show create update destroy]
      resources :users, only: %i[index update]
      resources :favorites, only: %i[index create destroy]
      resources :comments, only: %i[index create destroy]
      resources :rates, only: %i[index create update]
      resources :hotpeppers, only: %i[index]
      resources :labels, only: %i[index create destroy]
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
end
