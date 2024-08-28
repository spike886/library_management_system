require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:borrowing) { create(:borrowing) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(borrowing).to be_valid
    end

    it 'is not valid without a borrowed_at date' do
      borrowing.borrowed_at = nil
      expect(borrowing).not_to be_valid
    end

    it 'is valid without a returned_at date' do
      borrowing.returned_at = nil
      expect(borrowing).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  describe 'custom methods' do
    # Add tests for any custom methods in the Borrowing model
  end
end
