class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @books = Book.all
    @user = current_user
    logger.debug(@user);
  end
  
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = @user.id
    if @book.save
      @create_result = @book
      redirect_to show_book_url(id: @book.id)
    	flash[:message] = "Book successfully created."
    else
      @books = Book.all
      render :index
    end
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
    @user = current_user
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to show_book_url(id: @book.id)
    	flash[:message] = "Book was successfully update"
    else
      @user = current_user
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
