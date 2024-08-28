class Book < ApplicationRecord
  has_many :borrowings

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
