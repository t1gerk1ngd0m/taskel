namespace :reminder do
  desc '日次リマインダーメール'
  task task_reminder: :environment do
    Task.remind_tasks
  end
end
