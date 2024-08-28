require 'rails_helper'

RSpec.describe "/borrowings", type: :request do
  let(:user) { create(:user, :member) }
  let(:book) { create(:book) }
  let(:valid_attributes) {
    attributes_for(:borrowing)
  }

  let(:invalid_attributes) {
    { book_id: nil, user_id: nil, borrowed_at: nil }
  }

  before do
    sign_in user
  end

  xdescribe "GET /index" do
    it "renders a successful response" do
      Borrowing.create! valid_attributes
      get book_borrowings_url(book)
      expect(response).to be_successful
    end
  end

  xdescribe "POST /return" do
    context "with valid parameters" do
      it "set returned at" do
        borrowing = Borrowing.create! valid_attributes
        patch book_borrowing_return_url(book, borrowing)
        borrowing.reload
        expect(borrowing.returned_at).to be_present
      end
    end
  end

end