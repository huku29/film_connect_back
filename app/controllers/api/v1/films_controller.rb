class Api::V1::FilmsController < ApplicationController
  def search
    films = GetFilmData.search_films(params[:search_word], params[:page])

    render json: films, status: :ok
  end
end
