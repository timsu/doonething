class User < ActiveRecord::Base
  has_secure_password

  belongs_to :active_task, :class_name => 'Task'
  
  def find_next_task(options = {})
    Task.where(:user => self, :completed_at => nil).
      order("importance DESC, random() ASC").limit(1).first
  end

  def skip_task(task)
    Task.where(:user => self, :completed_at => nil).
      where("id != ?", task.id).
      order("importance * 2 - ifnull(postponed, 0) DESC, random(), created_at ASC").limit(1).first
  end

  def importances
    [
     "$0 - $5",
     "$5 - $25",
     "$25 - $50",
     "$50 - $100",
     "$100 - $500",
     "$500 - $1000",
     "$1000+"
    ]
  end  
  
end
