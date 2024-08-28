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

  describe "POST /borrow" do
    context "with valid parameters" do
      it "creates a new Borrowing" do
        expect {
          post borrow_book_borrowing_url(book), params: { borrowing: valid_attributes }
        }.to change(Borrowing, :count).by(1)
      end

      it "redirects to the created borrowing" do
        post borrowings_url, params: { borrowing: valid_attributes }
        expect(response).to redirect_to(borrowing_url(Borrowing.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Borrowing" do
        expect {
          post borrowings_url, params: { borrowing: invalid_attributes }
        }.to change(Borrowing, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post borrowings_url, params: { borrowing: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { returned_at: Time.now }
      }

      it "updates the requested borrowing" do
        borrowing = create(:borrowing)
        patch borrowing_url(borrowing), params: { borrowing: new_attributes }
        borrowing.reload
        expect(borrowing.returned_at).not_to be_nil
      end

      it "redirects to the borrowing" do
        borrowing = create(:borrowing)
        patch borrowing_url(borrowing), params: { borrowing: new_attributes }
        borrowing.reload
        expect(response).to redirect_to(borrowing_url(borrowing))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        borrowing = create(:borrowing)
        patch borrowing_url(borrowing), params: { borrowing: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested borrowing" do
      borrowing = create(:borrowing)
      expect {
        delete borrowing_url(borrowing)
      }.to change(Borrowing, :count).by(-1)
    end

    it "redirects to the borrowings list" do
      borrowing = create(:borrowing)
      delete borrowing_url(borrowing)
      expect(response).to redirect_to(borrowings_url)
    end
  end
end