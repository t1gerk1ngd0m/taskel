class RenameLabellingsToTaskLabels < ActiveRecord::Migration[5.2]
  def change
    rename_table :labellings, :task_labels
  end
end
