Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :received_letters, only: %i[index create] do 
        collection do
          get 'info'
        end
      end

      resources :letters, only: %i[index create] do
        collection do 
          get 'random'
          get 'random_by_english'
          get 'rank'
        end
      end

      resources :users, only: %i[create] do
        collection do
          get 'info'
        end
      end

      resources :not_watch_film_letters, only: %i[index create] do
        collection do
          get 'rank'
          get 'info'
          get 'not_watch_film_letters_detail'
        end
      end
      
      get 'films/search'
      get 'films/search_by_english'
      get 'films/info'
      get 'films/info_by_english'
    end
  end
end
