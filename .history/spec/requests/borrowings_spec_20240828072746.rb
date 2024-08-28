require 'rails_helper'

RSpec.describe "/borrowings", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) {
    { book_id: create(:book).id, user_id: user.id, borrowed_at: Time.now }
  }

  let(:invalid_attributes) {
    { book_id: nil, user_id: nil, borrowed_at: nil }
  }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:borrowing)
      get borrowings_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      borrowing = create(:borrowing)
      get borrowing_url(borrowing)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Borrowing" do
        expect {
          post borrowings_url, params: { borrowing: valid_attributes }
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