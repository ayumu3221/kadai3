class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end
  
  def create
    @book = Book.new(user_params)
    @book.user_id = current_user.id
    if@book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book)
    else
      render :index
    end
  end
  
  

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if@user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id) 
    else
    render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
