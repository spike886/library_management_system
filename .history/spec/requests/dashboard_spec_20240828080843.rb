require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    it "redirects to home page" do
      get "/dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

end
