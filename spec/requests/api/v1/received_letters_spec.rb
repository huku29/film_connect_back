require 'rails_helper'

RSpec.describe "Api::V1::ReceivedLetters", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/received_letters/create"
      expect(response).to have_http_status(:success)
    end
  end

end
