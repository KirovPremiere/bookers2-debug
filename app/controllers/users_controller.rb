class UsersController < ApplicationController
  before_action :authenticate_user! #home,aboutアイコンを押してもLoginの画面のまま
  before_action :ensure_correct_user, only: [:edit, :update] #他ユーザーのプロフィールを編集できないようにする

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id) #booksが未定義になっていたので追加！！！！！！！
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end #end無かったので付けました

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully." #users_pathをuser_pathに変更
    else
      render "edit" #失敗したときに飛ぶところ
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
