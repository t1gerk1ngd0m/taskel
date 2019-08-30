class TaskMailer < ApplicationMailer
  def send_deadline(user, tasks)
    @user = user
    @tasks = tasks
    mail  to: user.email,
          subject: 'タスクの期限が迫っています。'
  end
end
