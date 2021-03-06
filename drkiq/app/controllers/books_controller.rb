class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :checkout_book, :checkout_form]
  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    @books.each do |book_item|
      book_item.update_availability
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book.update_availability
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    # @book.library = @library
    respond_to do |format|
      @book.availability = @book.is_checked_out

      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      @book.availability = @book.is_checked_out

      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /genre_search
  def genre_search
    @all_books = Book.all
    @books = Book.where(nil)
    if params[:genres]
      for genre in params[:genres]
        @books = @all_books.filter_book_by_genre(genre) & @books
      end
    end
  end

  #GET /checkout_form
  def checkout_form
  end

  # POSt /checkout_book
  def checkout_book
    respond_to do |format|
      puts "params", params.inspect
      if self.find_user
        puts "this is the user", @user.inspect, params[:book][:username]
        params[:book][:user_id] = @user.id
        params[:book].delete :username
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully reserved.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :checkout_form }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def find_user
      @user = User.find_user_by_name(params[:book][:username])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      print "new params", params
      params.require(:book).permit(:name, :author, :return_by, :library_id, :user_id, :description, genre_ids: [])
    end
end
