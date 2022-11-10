class TasksController < ApplicationController
  before_action :set_user
  before_action :correct_user, only: [:index, :edit, :new, :create, :show, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = @user.tasks.new(task_params)
    
    params[:task][:status] = "未"
    if params[:task][:deadline].nil? || params[:task][:deadline].blank?
      @task.save
      flash[:success] = "新規作成成功しました。"
      redirect_to user_tasks_url
    else      
      if params[:task][:deadline].to_date < Date.current
        flash[:danger] = "期日は本日以降の日付にして下さい"
        render :new
      else
        @task.save
        flash[:success] = "新規作成成功しました。"
        redirect_to user_tasks_url
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if params[:task][:deadline].to_date < @task.created_at.to_date
      flash[:danger] = "期日はタスクの作成日以降の日付にして下さい"
      render :edit      
    else
      @task.update(task_update_params)
      @task.save
      redirect_to user_tasks_url @user
    end
  end

  def index
    @tasks = @user.tasks.order(created_at: :desc)
  end

  def show
    @task = @user.tasks.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
      redirect_to user_tasks_url @user
  end

  private

    def set_user 
      @user = User.find(params[:user_id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :status, :deadline)
    end

    def task_update_params
      params.require(:task).permit(:name, :description, :status, :deadline)
    end

    def current_user?(user)
      user == current_user
    end

    def correct_user
      unless current_user?(@user)
        flash[:danger] = "アクセスできません。"
        redirect_to root_url 
      end
    end


end
