require 'rails_helper'

RSpec.describe BookPolicy, type: :policy do
  let(:librarian) { build( :user, :librarian)
  let(:member) { build(:user, :member) }
  let(:guest) {build(user) }
  let(:book) { Book.new }

  subject { described_class }

  permissions ".scope" do
    it "allows librarians to see all books" do
      expect(BookPolicy::Scope.new(librarian, Book.all).resolve).to eq(Book.all)
    end

    it "allows members to see all books" do
      expect(BookPolicy::Scope.new(member, Book.all).resolve).to eq(Book.all)
    end

    it "does not allow guests to see any books" do
      expect(BookPolicy::Scope.new(guest, Book.all).resolve).to be_empty
    end
  end

  permissions :show? do
    it "allows librarians to view any book" do
      expect(subject).to permit(librarian, book)
    end

    it "allows members to view any book" do
      expect(subject).to permit(member, book)
    end

    it "does not allow guests to view any book" do
      expect(subject).not_to permit(guest, book)
    end
  end

  permissions :create? do
    it "allows librarians to create a book" do
      expect(subject).to permit(librarian, book)
    end

    it "does not allow members to create a book" do
      expect(subject).not_to permit(member, book)
    end

    it "does not allow guests to create a book" do
      expect(subject).not_to permit(guest, book)
    end
  end

  permissions :update? do
    it "allows librarians to update a book" do
      expect(subject).to permit(librarian, book)
    end

    it "does not allow members to update a book" do
      expect(subject).not_to permit(member, book)
    end

    it "does not allow guests to update a book" do
      expect(subject).not_to permit(guest, book)
    end
  end
end