module TasksHelper
  def alert_visible(group, task)
    if task.deadline > Time.zone.today
      link_to "#{task.title}の期限は明日です。期日:#{task.deadline}", task_path(task)
    elsif task.deadline == Time.zone.today
      link_to "#{task.title}の期限は本日です。期日:#{task.deadline}", task_path(task)
    else task.deadline < Time.zone.today
      link_to "#{task.title}の期限は超過しています。期日:#{task.deadline}", task_path(task)
    end
  end
end
