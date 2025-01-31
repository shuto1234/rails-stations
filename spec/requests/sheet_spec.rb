require 'rails_helper'

RSpec.describe "Sheets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sheet/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/sheet/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/sheet/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
