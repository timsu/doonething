class User < ActiveRecord::Base
  has_secure_password

  has_one :active_task, :class => Task

  def find_next_task
    Task.where(:user => self).order("importance DESC").limit(1).first
  end
  
end
