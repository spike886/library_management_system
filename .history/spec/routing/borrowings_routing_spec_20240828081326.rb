require "rails_helper"

RSpec.describe BorrowingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/borrowings").to route_to("borrowings#index")
    end

    it "routes to #return" do
      expect(post: "book/1/borrowings/1/return").to route_to("borrowings#return")
    end
  end
end