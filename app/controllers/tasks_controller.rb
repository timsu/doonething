class TasksController < ApplicationController

  def create
    @task = Task.new(task_params)
    @task.user = User.first

    if @task.importance.nil?
      @task.importance = 0
    end
    
    if @task.save
      session[:success] = "Task saved!"
    else
      session[:error] = @task.errors
    end
    
    redirect_to "/home"
  end
  
  
  private

  def task_params
    params.require(:task).permit(:title, :importance)
  end
  
end
