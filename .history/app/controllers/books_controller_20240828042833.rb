class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, except: [:index, :new]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  
  # GET /books
  # GET /books.json
  # @api public
  # @return [Array<Hash>] List of books
  # @example Request:
  #   GET /books
  # @example Response:
  #   HTTP/1.1 200 OK
  #   [
  #     {
  #       "id": 1,
  #       "title": "Book Title",
  #       "author": "Author Name",
  #       "genre": "Genre",
  #       "isbn": "1234567890",
  #       "total_copies": 5
  #     }
  #   ]
  def index
    @books = policy_scope(Book)

    if params[:query].present?
      @books = @books.where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ? OR isbn ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    end
    @books = @books.page(params[:page]).per(20)
  end


  # GET /books/:id
  # GET /books/:id.json
  # @api public
  # @param [Integer] id Book ID
  # @return [Hash] Book details
  # @example Request:
  #   GET /books/1
  # @example Response:
  #   HTTP/1.1 200 OK
  #   {
  #     "id": 1,
  #     "title": "Book Title",
  #     "author": "Author Name",
  #     "genre": "Genre",
  #     "isbn": "1234567890",
  #     "total_copies": 5
  #   }
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


  # POST /books
  # POST /books.json
  # @api public
  # @param [Hash] book Required fields: title, author, genre, isbn, total_copies
  # @return [Hash] Created book details
  # @example Request:
  #   POST /books
  #   {
  #     "title": "New Book",
  #     "author": "New Author",
  #     "genre": "New Genre",
  #     "isbn": "0987654321",
  #     "total_copies": 10
  #   }
  # @example Response:
  #   HTTP/1.1 201 Created
  #   {
  #     "id": 2,
  #     "title": "New Book",
  #     "author": "New Author",
  #     "genre": "New Genre",
  #     "isbn": "0987654321",
  #     "total_copies": 10
  #   }
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

  # PATCH/PUT /books/:id
  # PATCH/PUT /books/:id.json
  # @api public
  # @param [Integer] id Book ID
  # @param [Hash] book Optional fields: title, author, genre, isbn, total_copies
  # @return [Hash] Updated book details
  # @example Request:
  #   PATCH /books/1
  #   {
  #     "title": "Updated Book Title"
  #   }
  # @example Response:
  #   HTTP/1.1 200 OK
  #   {
  #     "id": 1,
  #     "title": "Updated Book Title",
  #     "author": "Author Name",
  #     "genre": "Genre",
  #     "isbn": "1234567890",
  #     "total_copies": 5
  #   }
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

    if @borrowing.update(returned_at: Time.current)
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
