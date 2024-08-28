require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end


    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: user.email)
      expect(user).not_to be_valid
    end

    it 'is not valid with an improperly formatted email' do
      user.email = 'invalid_email'
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:borrowings) }
    it { should have_many(:books).through(:borrowings) }
  end

  describe 'custom methods' do
    # Add tests for any custom methods here
  end
end
