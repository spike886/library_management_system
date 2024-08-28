require 'rails_helper'

RSpec.describe BorrowingPolicy, type: :policy do
  let(:librarian) { build( :user, :librarian) }
  let(:member) { build(:user, :member) }
  let(:guest) {build(:user, :guest) }
  let(:borrowing) { build(:borrowing) }

  subject { described_class }

  permissions ".scope" do
    it "allows librarians to see all borrowings" do
      expect(BorrowingPolicy::Scope.new(librarian, Borrowing.all).resolve).to eq(Borrowing.all)
    end

    it "does not allow guests to see any borrowings" do
      expect(BorrowingPolicy::Scope.new(guest, Borrowing.all).resolve).to be_empty
    end
  end

  permissions :show? do
    it "does not allows librarians to borrowing" do
      expect(subject).not_to permit(librarian, borrowing)
    end

    it "allows members to view their own borrowing" do
      borrowing.user = member
      expect(subject).to permit(member, borrowing)
    end

    it "does not allow members to view others' borrowings" do
      borrowing.user = User.new(role: 'member')
      expect(subject).not_to permit(member, borrowing)
    end

    it "does not allow guests to view any borrowing" do
      expect(subject).not_to permit(guest, borrowing)
    end
  end

  permissions :create? do
    it "allows librarians to create a borrowing" do
      expect(subject).to permit(librarian, borrowing)
    end

    it "allows members to create a borrowing" do
      expect(subject).to permit(member, borrowing)
    end

    it "does not allow guests to create a borrowing" do
      expect(subject).not_to permit(guest, borrowing)
    end
  end

  permissions :update? do
    it "allows librarians to update any borrowing" do
      expect(subject).to permit(librarian, borrowing)
    end

    it "allows members to update their own borrowing" do
      borrowing.user = member
      expect(subject).to permit(member, borrowing)
    end

    it "does not allow members to update others' borrowings" do
      borrowing.user = User.new(role: 'member')
      expect(subject).not_to permit(member, borrowing)
    end

    it "does not allow guests to update any borrowing" do
      expect(subject).not_to permit(guest, borrowing)
    end
  end
end