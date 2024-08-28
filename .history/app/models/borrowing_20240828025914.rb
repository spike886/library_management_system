class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  
  validates :user_id, if: -> { returned_at.nil? }, uniqueness: { scope: [:book_id, :returned_at], message: "has already borrowed this book" }
  validate :due_date_cannot_be_in_the_past

  private

  def due_date_cannot_be_in_the_past
    return if due_at.blank?
    if due_at < Date.today
      errors.add(:due_at, "can't be in the past")
    end
  end
end
