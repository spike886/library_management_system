class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing

  def create
    if @book.available?
      @borrowing = current_user.borrowings.new(book: @book, borrowed_on: Time.current, due_on: 2.weeks.from_now)
      if @borrowing.save
        redirect_to books_path, notice: 'Book was successfully borrowed.'
      else
        redirect_to books_path, alert: @borrowing.errors.full_messages.to_sentence
      end
    else
      redirect_to books_path, alert: 'Book is not available.'
    end
  end

  def return_book
    @borrowing = current_user.borrowings.find_by(book_id: params[:id], returned_on: nil)
    if @borrowing
      @borrowing.update(returned_on: Time.current)
      redirect_to books_path, notice: 'Book was successfully returned.'
    else
      redirect_to books_path, alert: 'Book was not borrowed or already returned.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
