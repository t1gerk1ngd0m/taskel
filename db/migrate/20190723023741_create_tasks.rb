class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.date :deadline
      t.integer :status, null: false
      t.string :file

      t.timestamps
    end
  end
end
