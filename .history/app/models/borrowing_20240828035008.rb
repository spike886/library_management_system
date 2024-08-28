class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  
  validates :user_id, if: -> { returned_at.nil? }, uniqueness: { scope: [:book_id, :returned_at], message: "has already borrowed this book" }
  validate :due_date_cannot_be_in_the_past
  validate :book_availability, on: :create

  private

  def due_date_cannot_be_in_the_past
    return if due_at.blank?
    if due_at < Date.today
      errors.add(:due_at, "can't be in the past")
    end
  end

  def book_availability
    if book.borrowings.where(returned_at: nil).count >= book.total_copies
      errors.add(:book, 'is not available for borrowing')
    end
  end
end
