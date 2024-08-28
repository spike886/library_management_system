class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing, only: [:return]
  after_action :verify_authorized

  # GET /books/:book_id/borrowings
  # GET /books/:book_id/borrowings.json
  api :GET, '/books/:book_id/borrowings', 'List all borrowings for a specific book'
  param :book_id, :number, desc: 'ID of the book for which borrowings are listed', required: true
  param :page, :number, desc: 'Page number for pagination', required: false
  def index
    @borrowings = Borrowing.includes(:book, :user).where(book_id: params[:book_id]).page(params[:page]).per(20)
    @book = Book.find(params[:book_id])
    authorize @borrowings
  end

  # PATCH/PUT /borrowings/:id/return
  # PATCH/PUT /borrowings/:id/return.json
  api :PATCH, '/borrowings/:id/return', 'Mark a borrowing as returned'
  param :id, :number, desc: 'ID of the borrowing to mark as returned', required: true
  def return
    if @borrowing.update(returned_at: Time.current)
      redirect_to book_borrowings_path(@borrowing.book), notice: 'Book was successfully returned.'
    else
      redirect_to book_borrowings_path(@borrowing.book), alert: 'Book could not be returned.'
    end
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
    authorize @borrowing
  end
end
