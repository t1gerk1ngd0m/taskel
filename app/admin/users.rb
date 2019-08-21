ActiveAdmin.register User do
  actions :all
  permit_params :name, :email, :password, :role
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  # 一覧ページ検索条件
  filter :name
  filter :email

  # 一覧ページ
  index do
    column :id
    column :name
    column :email
    column "タスク数", :tasks do |user|
      user.tasks.count
    end
    column :role
    actions 
  end

  # 詳細ページ
  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :role
    end
  end

  # 新規作成/編集ページ
  form do |f|
    inputs  do
      input :name
      input :email
      input :password
      input :role
    end
    actions
  end
end
