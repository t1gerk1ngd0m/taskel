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

  feature 'index page' do

    before do
      @task = Task.create(title: "タスクテスト１", body: "タスクテスト本文１", status: 1)
      @task = Task.create(title: "タスクテスト２", body: "タスクテスト本文２", status: 0, created_at: Time.current + 1.days)
      @task = Task.create(title: "タスクテスト３", body: "タスクテスト本文３", status: 2, created_at: Time.current + 2.days)
      @task = Task.create(title: "タスクテスト４", body: "タスクテスト本文４", status: 0, created_at: Time.current + 3.days)
    end

    scenario 'succeed in task destruction in index page', type: :system do
      visit root_path

      first(".delete").click_on('削除')

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content("タスクを削除しました")
    end

    scenario 'sorted by creation date', type: :system do
      visit root_path
      created_at = all(".task-index__task--created_at")

      expect(page).to have_content("タスク一覧")

      # i番目のデータの作成日時がi+1番目のデータの作成日時よりもあとであることを確認
      4.times do |i|
        if(created_at[i+1])
          expect(created_at[i].text()).to be > created_at[i+1].text()
        end
      end
    end
  end

  feature 'show page' do

    before do
      @task = Task.create(title: "タスクテスト", body: "タスクテスト本文", status: 1)
    end

    scenario 'succeed in task destruction in show page', type: :system do
      visit task_path(id: @task.id)

      click_on '削除'

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content("タスクを削除しました")
    end
  end

  # all('a').map { |link| link[:href] }.reject{ |url| url.nil? }.each do |url|
  #   visit url
  #   expect(page).to have_http_status(:success)
  # end


end