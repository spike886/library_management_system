require "rails_helper"

RSpec.describe BorrowingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/books/1/borrowings").to route_to("borrowings#index", book_id: "1")
    end

    it "routes to #return" do
      expect(patch: "/books/1/borrowings/1/return").to route_to("borrowings#return", book_id: "1", id: "1")
    end
  end
end