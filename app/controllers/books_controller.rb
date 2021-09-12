class BooksController < ApplicationController
  before_action :authenticate_user! #home,aboutアイコンを押してもLoginの画面のまま

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new #何も情報が入ってない空のモデルを渡してあげる
  end

  def index
    @books = Book.all
    @book = Book.new #新しく作るために空のボックスを渡す
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id #ログイン中にURLを入力すると他人が投稿した本の編集ページに遷移できないようにする
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy #destroyに名前変更
    @book = Book.find(params[:id])
    @book.destroy #destroyのrが抜けておりました
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body) #bodyも一緒に受け渡し
  end
  
  

end
