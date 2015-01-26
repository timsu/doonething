class User < ActiveRecord::Base
  has_secure_password

  has_one :active_task, :class => Task

  def find_next_task
    Task.where(:user => self).order("importance DESC").limit(1).first
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
