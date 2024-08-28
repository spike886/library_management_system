class Book < ApplicationRecord
  acts_as_paranoid

  has_many :borrowings
  has_many :users, through: :borrowings

  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :total_copies, presence: true, numericality: { greater_than: 0 }

  def available?
    available_copies > 0
  end

  def available_copies
    total_copies - borrowings.where(returned_at: nil).count
  end
end
