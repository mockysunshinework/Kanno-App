class RequestsController < ApplicationController
  before_action :set_user
  before_action :correct_user
  before_action :no_department_user

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

# 以前に作成した自作のcreateアクション。ifやunlessが多く、見づらいため新しいアクションを作成してみる　
  # def create
  #   @request = @user.requests.new(request_params)
    
  #   params[:request][:request_status] = "未"
  #   if params[:request][:request_name].present? && params[:request][:request_description].present?
  #     unless params[:request][:request_deadline].nil? || params[:request][:request_deadline].blank?
  #       if params[:request][:request_deadline].to_date < Date.current 
  #         flash[:danger] = "本日以降の期日を設定して下さい。"
  #         render :new
  #       else
  #         @request.save
  #         flash[:success] = "新規作成成功しました。"
  #         redirect_to user_requests_url
  #       end
  #     else
  #       flash[:danger] = "本日以降の期日を設定して下さい。"
  #       render :new
  #     end
  #   else
  #     flash[:danger] = "リクエスト名とリクエスト詳細は入力必須です。"
  #     render :new
  #   end
  # end   

  def index
    @user = User.find(params[:user_id])
    @requests = @user.requests.order(created_at: :desc)
  end

  def edit
    @request = Request.find(params[:id])
  end

  # def update
  #   @request = Request.find(params[:id])
  #   if params[:request][:request_deadline].blank? || params[:request][:request_deadline].to_date < Date.current
  #     flash[:danger] = "本日以降の期日を入力して下さい。"
  #     redirect_to edit_user_request_path(@user, @request) and return
  #   else
  #     @request.update(request_params)
  #     flash[:success] = "リクエストを変更しました"
  #     redirect_to user_requests_path(@user)
  #   end
  # end

  def update
    @request = Request.find(params[:id])
    if @request.update(request_params)
      flash[:success] = "リクエストを変更しました"
      redirect_to user_requests_path(@user)
    else
     render :edit      
    end
  end

  # createアクションの作り直しが成功したのとrequest.rbにうまく記述できたことを受けて、updateアクションを作り直す
  # def update
  #   @request = Request.find(params[:id])
  #   unless params[:request][:request_deadline].blank? || params[:request][:request_deadline].to_date < Date.current
  #     @request.update(request_params)
  #     flash[:success] = "リクエストを変更しました"
  #     redirect_to user_requests_path(@user)
  #   else
  #     flash[:danger] = "本日以降の期日を入力して下さい。"
  #     redirect_to edit_user_request_path(@user, @request)     
  #   end
  # end

  def edit_request
    @request = Request.find(params[:request_id])
    @partners = User.where(partner: true).where(department: @user.department).where.not(id: @user.id)
  end

  def send_request
    @request = Request.find(params[:request_id])
    if send_request_params[:partner_number].blank?
      
     flash[:danger] = "依頼先を選択して下さい。"
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

  def no_department_user
    unless current_user.department.present?
      flash[:warning] = "リクエスト機能は家族IDを設定してから利用可能です。"
      redirect_to user_path(@user)
    end
  end 
  
end
