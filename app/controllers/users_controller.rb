class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
  end
  
  def edit
      if current_user.id != params[:id].to_i
        redirect_to user_path(current_user.id)
      end
      @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(id: @user.id)
    	flash[:message] = "User was successfully update"
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
