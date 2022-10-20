class TasksController < ApplicationController
  before_action :set_user

  def index
    @tasks = @user.tasks
  end

  def new
    @task = Task.new
  end

  def show
    @task = @user.tasks.find(params[:id])

  end

  private

    def set_user 
      @user = User.find(params[:user_id])
    end


end
