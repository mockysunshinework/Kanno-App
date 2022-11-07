class RequestsController < ApplicationController
  before_action :set_user

  def new
    @request = Request.new
  end

  def create
    @request = @user.requests.new(request_params)
    
    params[:request][:request_status] = "未"
    if params[:request][:request_deadline].to_date < Date.current
      flash[:danger] = "期限が無効です。"
      render :new
    else
      if @request.save
        flash[:success] = "新規作成成功しました。"
        redirect_to user_requests_url
      else
        render :new
      end
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
     redirect_to user_request_edit_request_path(@user, @request) and return
   else
     @request.update(send_request_params)
     @partner = User.find(@request.partner_number)
     flash[:success] = "#{@partner.name}にタスクを依頼しました。"
     
   end
    redirect_to user_requests_url(@user)
  end

  def check_requests
    @requests = Request.where(partner_number: @user.id).where(request_status: "未").order(:request_deadline).group_by(&:user_id)
  end

  def finish_requests
    c1 = 0
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      finish_request_params.each do |id, item|
        request = Request.find(id)
        if item[:request_change_status] == "1"
          if item[:request_status] == "未"
            item[:request_change_status] = nil
          end
          c1 += 1
          request.update!(item)
        end
      end
    end
    flash[:success] = "#{c1}件のリクエストを実施済みに変更しました。"
    redirect_to @user
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、リクエスト処理をキャンセルしました。"
    redirect_to @user   
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:success] = "リクエストの削除に成功しました。"
      redirect_to user_requests_url @user
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

  def finish_request_params
    params.require(:user).permit(requests: [:request_status, :request_change_status])[:requests]
  end

end
