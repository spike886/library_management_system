class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_librarian
  before_action :set_borrowing, only: [:return]

  def index
    @borrowings = Borrowing.includes(:book, :user).all
  end

  def return
    authorize @borrowing

    if @borrowing.update(returned_on: Time.current)
      redirect_to borrowings_path, notice: 'Book was successfully returned.'
    else
      redirect_to borrowings_path, alert: 'Book could not be returned.'
    end
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
    autorize @borrowing
  end
end
