class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
    
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_path
  end

end
