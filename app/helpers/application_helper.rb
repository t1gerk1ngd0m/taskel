module ApplicationHelper
  def sortable(column, title = nil)
    title = column.titleize if title.blank?
    # 並べ替え元のカラム名のリンクのcssクラスとして、並び替え順に合わせてcurrent ascまたはcurrent descを付与する
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    # 並べ替え元のカラムにasc or descを与える
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end
end
