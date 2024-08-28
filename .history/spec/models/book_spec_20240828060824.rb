require 'rails_helper'

RSpec.describe Book, type: :model do
  # Define a valid book for use in the tests
  let(:book) { build(:book) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(book).to be_valid
    end

    it 'is not valid without a title' do
      book.title = nil
      expect(book).not_to be_valid
    end

    it 'is not valid without an author' do
      book.author = nil
      expect(book).not_to be_valid
    end

    it 'is not valid without a genre' do
      book.genre = nil
      expect(book).not_to be_valid
    end

    it 'is not valid without an ISBN' do
      book.isbn = nil
      expect(book).not_to be_valid
    end

    it 'is not valid with a duplicate ISBN' do
      create(:book, isbn: book.isbn)
      expect(book).not_to be_valid
    end

    it 'is not valid without total copies' do
      book.total_copies = nil
      expect(book).not_to be_valid
    end

    it 'is not valid with total copies less than 1' do
      book.total_copies = 0
      expect(book).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:borrowings) }
    it { should have_many(:users).through(:borrowings) }
  end

  describe 'custom methods' do
    # Add tests for any custom methods in the Book model
  end
end