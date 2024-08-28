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

  describe "GET /index" do
    it "renders a successful response" do
      Borrowing.create! valid_attributes
      get book_borrowings_url(book)
      expect(response).to be_successful
    end
  end

  describe "POST /return" do
    context "with valid parameters" do
      it "set returned at" do
        expect {
          post return_book_book_path(book), params: { borrowing: valid_attributes }
        }.to change(Borrowing, :count).by(1)
      end
    end
  end

end