class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    
    params[:request][:request_status] = "未"
    if @request.save
  
      flash[:success] = "新規作成成功しました。"
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:request_name, :request_description, :request_status, :request_deadline)
  end
end
