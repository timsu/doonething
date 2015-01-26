class HomeController < ApplicationController

  def index
  end

  def home
    @user = User.first
    @task = @user.active_task
    @active = @task

    if @task.nil?
      @task = @user.find_next_task
    end
    
    @title = @task.title if @task

    @task_importances = @user.importances.each_with_index.map { |x, i| [x, i] }
    
    @new_task = Task.new
  end
  
end
