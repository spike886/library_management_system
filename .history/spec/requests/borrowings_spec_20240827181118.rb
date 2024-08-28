require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/borrowings", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Borrowing. As you add validations to Borrowing, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Borrowing.create! valid_attributes
      get borrowings_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      borrowing = Borrowing.create! valid_attributes
      get borrowing_url(borrowing)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_borrowing_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      borrowing = Borrowing.create! valid_attributes
      get edit_borrowing_url(borrowing)
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

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post borrowings_url, params: { borrowing: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested borrowing" do
        borrowing = Borrowing.create! valid_attributes
        patch borrowing_url(borrowing), params: { borrowing: new_attributes }
        borrowing.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the borrowing" do
        borrowing = Borrowing.create! valid_attributes
        patch borrowing_url(borrowing), params: { borrowing: new_attributes }
        borrowing.reload
        expect(response).to redirect_to(borrowing_url(borrowing))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        borrowing = Borrowing.create! valid_attributes
        patch borrowing_url(borrowing), params: { borrowing: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested borrowing" do
      borrowing = Borrowing.create! valid_attributes
      expect {
        delete borrowing_url(borrowing)
      }.to change(Borrowing, :count).by(-1)
    end

    it "redirects to the borrowings list" do
      borrowing = Borrowing.create! valid_attributes
      delete borrowing_url(borrowing)
      expect(response).to redirect_to(borrowings_url)
    end
  end
end
