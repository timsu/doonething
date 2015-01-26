class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, :presence => true,
                    :length => { :minimum => 1 }
  validates :user_id, :presence => true

  def complete
    self.completed_at = Time.now
  end
  
  def completed?
    self.completed_at?
  end

  def delete
    self.deleted_at = Time.now
  end

  def deleted?
    self.deleted_at?
  end

  def inc_postponed
    self.postponed = (self.postponed || 0) + 1
  end
  
end
