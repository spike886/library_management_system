class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.librarian?
      @total_books = Book.count
      @total_borrowed_books = Borrowing.where(returned_at: nil).count
      @books_due_today = Borrowing.where(due_at: Date.today, returned_at: nil).includes(:book)
      @members_with_overdue_books = User.joins(:borrowings)
                                         .where('borrowings.due_at < ? AND borrowings.returned_at IS NULL', Date.today)
                                         .distinct
    elsif current_user.member?
      @borrowings = current_user.borrowings.includes(:book)
    end
  end
end
