class RequestsController < ApplicationController
  before_action :set_user

  def new
    @request = Request.new
  end

  def create
    @request = @user.requests.new(request_params)
    
    params[:request][:request_status] = "未"
      if @request.save
        flash[:success] = "新規作成成功しました。"
        redirect_to user_requests_url
      else
        render :new
      end
  end   

  def index
    @user = User.find(params[:user_id])
    @requests = @user.requests.order(created_at: :desc)
  end

  def edit_request
    @request = Request.find(params[:request_id])
  end

  private

  def set_user 
    @user = User.find(params[:user_id])
  end

  def request_params
    params.require(:request).permit(:request_name, :request_description, :request_status, :request_deadline)
  end
end
