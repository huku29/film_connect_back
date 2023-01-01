Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/received_letters', to: 'received_letters#index'
      get '/received_letters/info', to: 'received_letters#info'
      post '/received_letters', to: 'received_letters#create'
      get '/letters', to: 'letters#index'
      get 'letters/random', to: 'letters#random'
      post '/letters', to: 'letters#create'
      get '/users/info', to: 'users#info'
      post '/users', to: 'users#create'
      get 'films/search'
      get 'films/info'
    end
  end
end
