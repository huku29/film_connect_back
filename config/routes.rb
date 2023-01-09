Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/received_letters', to: 'received_letters#index'
      get '/received_letters/info', to: 'received_letters#info'
      post '/received_letters', to: 'received_letters#create'
      get '/letters', to: 'letters#index'
      get 'letters/random', to: 'letters#random'
      get '/letters/rank', to:'letters#rank'
      post '/letters', to: 'letters#create'
      get '/users/info', to: 'users#info'
      post '/users', to: 'users#create'
      get 'films/search'
      get 'films/info'
      get '/not_watch_film_letters', to: 'not_watch_film_letters#index'
      get '/not_watch_film_letters/rank', to: 'not_watch_film_letters#rank'
      get '/not_watch_film_letters/info', to: 'not_watch_film_letters#info'
      get '/not_watch_film_letters/not_watch_film_letters_detail', to: 'not_watch_film_letters#not_watch_film_letters_detail'
      post '/not_watch_film_letters', to: 'not_watch_film_letters#create'
    end
  end
end
