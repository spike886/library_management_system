class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing, only: [:return]
  after_action :verify_authorized

  def index
    @borrowings = Borrowing.includes(:book, :user).all
    authorize @borrowings
  end

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
