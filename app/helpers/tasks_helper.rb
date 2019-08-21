module TasksHelper
  def alert_visible(task)
    if task.deadline > Time.zone.today
      link_to "#{task.title}の期限は明日です。期日:#{task.deadline}", task_path(task.id)
    elsif task.deadline == Time.zone.today
      link_to "#{task.title}の期限は本日です。期日:#{task.deadline}", task_path(task.id)
    else task.deadline < Time.zone.today
      link_to "#{task.title}の期限は超過しています。期日:#{task.deadline}", task_path(task.id)
    end
  end
end
