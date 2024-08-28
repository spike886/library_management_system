class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, except: [:index, :new]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /books or /books.json
  def index
    @books = policy_scope(Book)

    if params[:query].present?
      @books = @books.where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    end
  end


  # GET /books/1 or /books/1.json
  def show
    @borrowing = current_user.borrowings.find_by(book: @book, returned_at: nil)
  end

  # GET /books/new
  def new
    @book = Book.new
    authorize @book
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    authorize @book

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def borrow
    @borrowing = current_user.borrowings.new(book: @book, borrowed_at: Time.current, due_at: 2.weeks.from_now)

    authorize @borrowing

    if @borrowing.save
      redirect_to books_path, notice: 'Book was successfully borrowed.'
    else
      redirect_to books_path, alert: @borrowing.errors.full_messages.to_sentence
    end
  end

  def return_book
    @borrowing = current_user.borrowings.find_by(book_id: params[:id], returned_at: nil)
    authorize @borrowing

    if @borrowing.update(returned: Time.current)
      redirect_to books_path, notice: 'Book was successfully returned.'
    else
      redirect_to books_path, alert: 'Book could not be returned.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = policy_scope(Book).find(params[:id])
      authorize @book
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
    end
end
