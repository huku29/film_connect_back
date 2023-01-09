require 'rails_helper'

RSpec.describe "Api::V1::NotWatchFilmLetters", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/not_watch_film_letters/create"
      expect(response).to have_http_status(:success)
    end
  end

end
