class PagesController < ApplicationController
  before_action :authenticate_user!
  
  def home
    # Add any general logic or content for the home page if needed
  end

  def dashboard
    if current_user.librarian?
      @total_books = Book.count
      @total_borrowed_books = Borrowing.where(returned: false).count
      @books_due_today = Borrowing.where(due_at: Date.today)
      @overdue_members = Borrowing.where('due_at < ? AND returned = ?', Date.today, false).map(&:user).uniq
    else
      @borrowings = current_user.borrowings
      @overdue_books = @borrowings.where('due_at < ? AND returned = ?', Date.today, false)
    end
  end
end
