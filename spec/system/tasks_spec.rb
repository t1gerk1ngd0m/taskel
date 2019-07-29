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

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content("タスクを作成しました")
    end

    scenario 'fail in task creation', type: :system do
      visit new_task_path

      click_button '作成する'

      expect(page).to_not have_content("タスク一覧")
      expect(page).to have_content("タスクの作成に失敗しました")
    end
  end

  feature 'edit page' do

    before do
      @task = Task.create(title: "タスクテスト", body: "タスクテスト本文", status: 1)
    end

    scenario 'succeed in task editation', type: :system do
      visit edit_task_path(id: @task.id)

      fill_in 'task_title', with: @task.title
      fill_in 'task_body', with: @task.body
      select @task.status ,from: 'task_status'
      click_button '編集する'

      expect(page).to have_content("タスク詳細")
      expect(page).to have_content("タスクを編集しました")
    end

    scenario 'fail in task editation', type: :system do
      visit edit_task_path(id: @task.id)

      fill_in 'task_title', with: ''
      click_button '編集する'

      expect(page).to_not have_content("タスク詳細")
      expect(page).to have_content("タスクの編集に失敗しました")
    end
  end

  # all('a').map { |link| link[:href] }.reject{ |url| url.nil? }.each do |url|
  #   visit url
  #   expect(page).to have_http_status(:success)
  # end


end