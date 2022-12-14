require 'rails_helper'

RSpec.describe "Api::V1::Films", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/api/v1/films/search"
      expect(response).to have_http_status(:success)
    end
  end

end
