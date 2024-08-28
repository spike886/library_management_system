class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_borrowing, only: [:return_book]
  after_action :verify_authorized
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_borrowing
    @borrowing = current_user.borrowings.find_by(book_id: params[:id], returned: false)
  end
end
