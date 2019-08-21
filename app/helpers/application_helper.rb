module ApplicationHelper
  def sortable(column, title = nil)
    title = column.titleize if title.blank?
    # 並べ替え元のカラム名のリンクのcssクラスとして、並び替え順に合わせてcurrent ascまたはcurrent descを付与する
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    # 並べ替え元のカラムにasc or descを与える
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end

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
