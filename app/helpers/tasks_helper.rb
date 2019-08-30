module TasksHelper
  def alert_visible(group, task)
    if task.deadline > Time.zone.today
      link_to "#{task.title}の期限は明日です。期日:#{task.deadline}", group_task_path(group, task)
    elsif task.deadline == Time.zone.today
      link_to "#{task.title}の期限は本日です。期日:#{task.deadline}", group_task_path(group, task)
    else task.deadline < Time.zone.today
      link_to "#{task.title}の期限は超過しています。期日:#{task.deadline}", group_task_path(group, task)
    end
  end

  def task_reminder(task)
    if task.deadline > Time.zone.today
      "#{task.title}の期限は明日です。期日:#{task.deadline}"
    elsif task.deadline == Time.zone.today
      "#{task.title}の期限は本日です。期日:#{task.deadline}"
    else task.deadline < Time.zone.today
      "#{task.title}の期限は超過しています。期日:#{task.deadline}"
    end
  end
end
