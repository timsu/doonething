class TasksController < ApplicationController

  before_filter :restrict_access
  
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    @task.importance = params[:importance]
    
    if @task.save
      flash[:success] = "Task saved!"
    else
      flash[:error] = @task.errors
    end
    
    redirect_to "/home"
  end
  
  def skip
    if current_user.active_task == @task
      new_task = current_user.skip_task @task
      if new_task
        current_user.active_task = new_task
        current_user.save

        @task.inc_postponed
        @task.save
      else
        flash[:error] = "No other tasks left"
        flash[:unskippable] = true
      end
    end
      
    redirect_to "/home"
  end

  def complete
    @task.complete
    @task.save

    if current_user.active_task == @task
      current_user.active_task_id = nil
      current_user.save
    end

    redirect_to "/home"
  end

  def forget
    redirect_to "/home"
  end
  
  private

  def task_params
    params.require(:task).permit(:title, :importance)
  end

  def restrict_access
    if params[:id]
      @task = Task.find params[:id]
      if @task.user != current_user
        head :unauthorized
      end
    end
  end
  
end
