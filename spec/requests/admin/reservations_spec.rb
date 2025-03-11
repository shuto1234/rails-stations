require 'rails_helper'

RSpec.describe "Admin::Reservations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/reservations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/reservations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/reservations/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/admin/reservations/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
