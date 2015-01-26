class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.string :title
      t.integer :importance
      t.integer :postponed
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps null: false
    end
    add_foreign_key :tasks, :users
  end
end
