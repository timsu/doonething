class HomeController < ApplicationController

  def index
  end

  def home
    @task = current_user.active_task

    if @task.nil? or @task.completed?
      @task = current_user.find_next_task
      current_user.active_task = @task
      current_user.save
    end
    
    @title = @task.title if @task

    @task_importances = current_user.importances.each_with_index.map { |x, i| [x, i] }
    
    @new_task = Task.new
  end
  
end
