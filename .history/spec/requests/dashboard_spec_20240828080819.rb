require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    it "redirects to home page" do
      get "/dashboard/index"
      expect(response).to redirect_to(root_path)
    end
  end

end
