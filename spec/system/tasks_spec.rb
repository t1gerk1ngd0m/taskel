require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  # before do
  #   @task = Task.create(title: 'タスク３３３', body: 'タスク本文', status: 1)
  # end

  feature 'new page' do

    given(:task) { Task.create(
      title: "タスクタイトル",
      body: "タスク本文",
      status: 0
    ) }

    scenario 'succeed in task creation', type: :system do
      visit new_task_path
      fill_in 'task_title', with: task.title
      fill_in 'task_body', with: task.body
      select task.status ,from: 'task_status'

      click_button '作成する'
      binding.pry
      # expect(response).to redirect_to(root_path)
      expect(page).to have_content("タスクを作成しました")
    end

    scenario 'fail in task creation', type: :system do
      visit new_task_path
      click_button '作成する'
      expect(page).to have_content("タスクの作成に失敗しました")
    end
  end

  # all('a').map { |link| link[:href] }.reject{ |url| url.nil? }.each do |url|
  #   visit url
  #   expect(page).to have_http_status(:success)
  # end


end