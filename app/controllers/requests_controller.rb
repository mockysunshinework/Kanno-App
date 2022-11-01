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
    @partners = User.where(partner: true).where(department: @user.department).where.not(id: @user.id)
  end

  def send_request
    @request = Request.find(params[:request_id])

    if send_request_params[:partner_number].blank?
      
     flash[:danger] = "必須です。"
   else
     @request.update(send_request_params)
     @partner = User.find(@request.partner_number)
     flash[:success] = "#{@partner.name}にタスクを依頼しました。"
     
   end
    redirect_to user_requests_url(@user)
  end


  private

  def set_user 
    @user = User.find(params[:user_id])
  end

  def request_params
    params.require(:request).permit(:request_name, :request_description, :request_status, :request_deadline)
  end

  def send_request_params
    params.require(:request).permit(:partner_number)
  end

end
