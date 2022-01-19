class BooksController < ApplicationController
    
  def index
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
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
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to show_book_url(id: @book.id)
    	flash[:message] = "Book was successfully update"
    else
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
    params.require(:book).permit(:title, :body)
  end
end
