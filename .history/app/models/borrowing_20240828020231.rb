class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: { scope: :book_id, message: "has already borrowed this book" }
  validate :due_date_cannot_be_in_the_past

  private

  def due_date_cannot_be_in_the_past
    return if due_on.blank?
    if due_on < Date.today
      errors.add(:due_on, "can't be in the past")
    end
  end
end
