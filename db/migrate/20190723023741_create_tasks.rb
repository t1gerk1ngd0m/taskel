class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :body
      t.date :deadline
      t.integer :status
      t.string :file

      t.timestamps
    end
  end
end
