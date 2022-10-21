class TasksController < ApplicationController
  before_action :set_user

  def new
    @task = Task.new
  end

  def create
    @task = @user.tasks.new(task_params)
    if @task.save
      flash[:success] = "新規作成成功しました。"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def edit
    @task = @user.tasks.find(params[:id])
  end

  def index
    @tasks = @user.tasks.order(created_at: :desc)
  end

  def show
    @task = @user.tasks.find(params[:id])

  end

  private

    def set_user 
      @user = User.find(params[:user_id])
    end

    def task_params
      params.require(:task).permit(:name, :description)
    end


end
