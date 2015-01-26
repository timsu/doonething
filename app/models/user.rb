class User < ActiveRecord::Base
  has_secure_password

  belongs_to :active_task, :class => Task
  
  def find_next_task(options = {})
    query = Task.where(:user => self, :completed_at => nil)
    if options[:skip_task]
      query = query.where("id != ?", options[:skip_task])
    end
    query.order("importance DESC, random(), created_at ASC").limit(1).first
  end

  def skip_task(task)
    find_next_task :skip_task => task.id
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
