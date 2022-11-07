class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
    
  end

  def show
    @user = User.find(params[:id])
    @requests = @user.requests.where.not(request_status: nil)
    @recieve_requests = Request.where(partner_number: @user.id).where(request_status: "未")
    @recieve_finished_requests = Request.where.not(partner_number: @user.id).where(request_status: "実施済み").where(request_change_status: true)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_path
  end

end
