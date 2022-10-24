class TasksController < ApplicationController
  before_action :set_user

  def new
    @task = Task.new
  end

  def create
    @task = @user.tasks.new(task_params)
    params[:task][:finished_task] = "false"
    if @task.save
      flash[:success] = "新規作成成功しました。"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_update_params)
      @task.save
      redirect_to user_tasks_url @user
    else
      render :edit
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
      params.require(:task).permit(:name, :description, :finished_task)
    end

    def task_update_params
      params.require(:task).permit(:name, :description, :finished_task)
    end


end
