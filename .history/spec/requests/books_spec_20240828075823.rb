require 'rails_helper'

RSpec.describe "/books", type: :request do
  let(:user) { create(:user, :librarian) }
  
  let(:valid_attributes) {
    attributes_for(:book)
  }

  let(:invalid_attributes) {
    { title: "", author: "", published_date: "" }
  }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:book)
      get books_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      book = create(:book)
      get book_url(book)
      expect(response).to be_successful
    end
  end

  xdescribe "POST /create" do
    context "with valid parameters" do
      it "creates a new Book" do
        expect {
          post books_url, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it "redirects to the created book" do
        post books_url, params: { book: valid_attributes }
        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book" do
        expect {
          post books_url, params: { book: invalid_attributes }
        }.to change(Book, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post books_url, params: { book: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { title: "Updated Book Title", author: "Updated Author" }
      }

      it "updates the requested book" do
        book = create(:book)
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(book.title).to eq("Updated Book Title")
        expect(book.author).to eq("Updated Author")
      end

      it "redirects to the book" do
        book = create(:book)
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(response).to redirect_to(book_url(book))
      end
    end

    context "with invalid parameters" do
      xit "renders a successful response (i.e. to display the 'edit' template)" do
        book = create(:book)
        patch book_url(book), params: { book: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested book" do
      book = create(:book)
      expect {
        delete book_url(book)
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      book = create(:book)
      delete book_url(book)
      expect(response).to redirect_to(books_url)
    end
  end
end