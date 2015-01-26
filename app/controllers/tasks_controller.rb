class TasksController < ApplicationController

  def create
    @task = Task.new(task_params)
    @task.user = User.first

    @task.importance = params[:importance]
    
    if @task.save
      flash[:success] = "Task saved!"
    else
      flash[:error] = @task.errors
    end
    
    redirect_to "/home"
  end
  
  
  private

  def task_params
    params.require(:task).permit(:title, :importance)
  end
  
end
