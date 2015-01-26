class UpdateTasksAddNotesDeleted < ActiveRecord::Migration
  def change
    add_column :tasks, :deleted_at, :datetime
    add_column :tasks, :notes, :text
  end
end
