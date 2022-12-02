Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/letters', to: 'letters#create'
      post '/users', to: 'users#create'
      get 'films/search'
    end
  end
end
