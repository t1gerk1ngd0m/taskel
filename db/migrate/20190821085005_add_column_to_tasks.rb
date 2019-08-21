class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :group, foreign_key: true, index: true
  end
end
