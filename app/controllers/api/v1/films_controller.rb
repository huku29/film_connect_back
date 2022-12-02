module Api
  module V1
    class FilmsController < ApplicationController
      def search
        films = GetFilmData.search_films(params[:search_word], params[:page])
    
        render json: films, status: :ok
      end
    end
  end
end

# class Api::V1::FilmsController < ApplicationController
#   def search
#     films = GetFilmData.search_films(params[:search_word], params[:page])

#     render json: films, status: :ok
#   end
# end