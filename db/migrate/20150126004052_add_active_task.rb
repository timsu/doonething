class AddActiveTask < ActiveRecord::Migration
  def change
    add_column :users, :active_task_id, :integer
  end
end
