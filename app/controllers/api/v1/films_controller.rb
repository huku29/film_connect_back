module Api
  module V1
    class FilmsController < ApplicationController
      def search
        films = GetFilmData.search_films(params[:search_word], params[:page])
        render json: films, status: :ok
      end

      def info
        detail = GetFilmData.detail_film(params[:film_id])
        render json: detail, status: :ok
      end
      
    end
  end
end