class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_borrowing, only: [:return_book]
  after_action :verify_authorized

  def borrow
    @borrowing = current_user.borrowings.new(book: @book, borrowed_on: Time.current, due_on: 2.weeks.from_now)

    authorize @borrowing

    if @borrowing.save
      redirect_to books_path, notice: 'Book was successfully borrowed.'
    else
      redirect_to books_path, alert: @borrowing.errors.full_messages.to_sentence
    end
  end

  def return_book
    authorize @borrowing

    if @borrowing.update(returned: true)
      redirect_to books_path, notice: 'Book was successfully returned.'
    else
      redirect_to books_path, alert: 'Book could not be returned.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_borrowing
    @borrowing = current_user.borrowings.find_by(book_id: params[:id], returned: false)
  end
end
