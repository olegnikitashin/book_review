class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :book_owner, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:category].blank?
      @books = Book.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to root_path, notice: "Your book was successfully saved"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Your book was successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path, notice: "Your book was successfully deleted"
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author, :category_id, :image)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def book_owner
    unless @book.user_id == current_user.id
      flash[:notice] = 'Only owners can edit their Books'
      redirect_to root_path
    end
  end
end
