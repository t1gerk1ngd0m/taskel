require 'rails_helper'

RSpec.describe 'Tasks', type: :system do

  before do
    @user = create(:user)
    login(@user)
  end

  feature 'new page' do

    given(:task) { create(:task,
      title: "タスクタイトル",
      body: "タスク本文",
      status: Task.statuses.key(0),
      priority: Task.priorities.key(1),
    ) }

    scenario 'succeed in task creation', type: :system do
      visit new_task_path

      fill_in I18n.t('activerecord.attributes.task.title'), with: task.title
      fill_in I18n.t('activerecord.attributes.task.body'), with: task.body
      select task.status_i18n ,from: I18n.t('activerecord.attributes.task.status')
      select task.priority_i18n ,from: I18n.t('activerecord.attributes.task.priority')

      click_button I18n.t('buttons.create')

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content(I18n.t('tasks.index.saved'))
      expect(page).to ( 
        have_content(task.title) && have_content(task.body) && have_content(task.status_i18n) && have_content(task.priority_i18n)
      )
    end

    scenario 'fail in task creation', type: :system do
      visit new_task_path

      click_button I18n.t('buttons.create')

      expect(page).to_not have_content("タスク一覧")
      expect(page).to have_content(I18n.t('tasks.new.save_failed'))
    end
  end

  feature 'edit page' do

    before do
      @task = Task.create(
        title: "タスクテスト", 
        body: "タスクテスト本文", 
        status: Task.statuses.key(1), 
        priority: Task.priorities.key(2),
        user_id: @user.id
      )
    end

    scenario 'succeed in task editation', type: :system do
      visit edit_task_path(id: @task.id)

      fill_in I18n.t('activerecord.attributes.task.title'), with: @task.title
      fill_in I18n.t('activerecord.attributes.task.body'), with: @task.body
      select @task.status_i18n ,from: I18n.t('activerecord.attributes.task.status')
      select @task.priority_i18n ,from: I18n.t('activerecord.attributes.task.priority')
      click_button I18n.t('buttons.update')

      expect(page).to have_content("タスク詳細")
      expect(page).to have_content(I18n.t('tasks.show.edited'))
      expect(page).to (
        have_content(@task.title) && have_content(@task.body) && have_content(@task.status_i18n) && have_content(@task.priority_i18n)
      )
    end

    scenario 'fail in task editation', type: :system do
      visit edit_task_path(id: @task.id)

      fill_in 'task_title', with: ''
      click_button I18n.t('buttons.update')

      expect(page).to_not have_content("タスク詳細")
      expect(page).to have_content(I18n.t('tasks.edit.edit_failed'))
    end
  end

  feature 'index page' do

    before do
      @task = Task.create(
        title: "タスクテスト１", 
        body: "タスクテスト本文１", 
        status: Task.statuses["working"], 
        deadline: Date.today + 10.days, 
        priority: Task.priorities["high"],
        user_id: @user.id
      )
      @task = Task.create(
        title: "タスクテスト２", 
        body: "タスクテスト本文２", 
        status: Task.statuses["waiting"], 
        deadline: Date.today + 20.days, 
        priority: Task.priorities["middle"], 
        created_at: Time.current + 1.days,
        user_id: @user.id
      )
      @task = Task.create(
        title: "タスクテスト３", 
        body: "タスクテスト本文３", 
        status: Task.statuses["finished"], 
        priority: Task.priorities["low"], 
        created_at: Time.current + 2.days,
        user_id: @user.id
      )
      @task = Task.create(
        title: "タスクテスト４", 
        body: "タスクテスト本文４", 
        status: Task.statuses["waiting"], 
        deadline: Date.today + 20.days, 
        priority: Task.priorities["low"], 
        created_at: Time.current + 3.days,
        user_id: @user.id
      )
    end

    scenario 'sorted by creation date in default', type: :system do
      visit root_path
      created_at_list = all(".task-index__task--created_at")
      # i番目のデータの作成日時がi+1番目のデータの作成日時よりもあとであることを確認
      4.times do |i|
        if(created_at_list[i+1])
          expect(created_at_list[i].text()).to be > created_at_list[i+1].text()
        end
      end
    end

    scenario 'sorted by creation date by asc', type: :system do
      visit root_path
      click_on I18n.t('activerecord.attributes.task.created_at')
      sleep 1
      created_at_list = all(".task-index__task--created_at")
      # i番目のデータの作成日時がi+1番目のデータの作成日時よりも前であることを確認
      4.times do |i|
        if(created_at_list[i+1])
          expect(created_at_list[i].text()).to be < created_at_list[i+1].text()
        end
      end
    end

    scenario 'sorted by deadline by asc', type: :system do
      visit root_path
      click_on I18n.t('activerecord.attributes.task.deadline')
      sleep 1
      deadline_list = all(".task-index__task--deadline")
      4.times do |i|
        if (deadline_list[i+1] && deadline_list[i+1].text().present?)
          expect(deadline_list[i].text()).to be <= deadline_list[i+1].text()
        end
      end
    end

    scenario 'sorted by deadline by desc', type: :system do
      visit root_path
      2.times do
        click_on I18n.t('activerecord.attributes.task.deadline')
      end
      sleep 1
      deadline_list = all(".task-index__task--deadline")
      4.times do |i|
        if (deadline_list[i+1] && deadline_list[i].text().present?)
          expect(deadline_list[i].text()).to be >= deadline_list[i+1].text()
        end
      end
    end

    scenario 'sorted by priority', type: :system do
      priority_hash = Task.priorities_i18n.keys.map { |k| [Task.priorities_i18n[k], Task.priorities[k]]}.to_h
      visit root_path
      click_on I18n.t('activerecord.attributes.task.priority')
      sleep 1
      priority_list = all(".task-index__task--priority")
      4.times do |i|
        if priority_list[i+1]
          expect(priority_hash[priority_list[i].text()]).to be <= priority_hash[priority_list[i+1].text()]
        end
      end

      click_on I18n.t('activerecord.attributes.task.priority')
      sleep 1
      priority_list = all(".task-index__task--priority")
      4.times do |i|
        if priority_list[i+1]
          expect(priority_hash[priority_list[i].text()]).to be >= priority_hash[priority_list[i+1].text()]
        end
      end
    end

    scenario 'suceeded in searching by title only', type: :system do
      visit root_path
      fill_in I18n.t('activerecord.attributes.task.title'), with: "２"
      find('#search').click
      expect(page).to have_content("タスクテスト２")
    end

    scenario 'failed in searching by title only', type: :system do
      visit root_path
      fill_in I18n.t('activerecord.attributes.task.title'), with: "タスクタスク"
      find('#search').click
      expect(page).to_not have_content("タスクテスト")
    end

    scenario 'searched by status only', type: :system do
      visit root_path
      select I18n.t('enums.task.status.working') ,from: "search-status"
      find('#search').click
      expect(page).to have_content("タスクテスト１")
    end

    scenario 'searched by title and status', type: :system do
      visit root_path
      fill_in I18n.t('activerecord.attributes.task.title'), with: "４"
      select I18n.t('enums.task.status.waiting') ,from: "search-status"
      find('#search').click
      expect(page).to have_content("タスクテスト４")
    end

    scenario 'searched by title and status', type: :system do
      visit root_path
      fill_in I18n.t('activerecord.attributes.task.title'), with: "４"
      select I18n.t('enums.task.status.working') ,from: "search-status"
      find('#search').click
      expect(page).to_not have_content("タスクテスト")
    end
  end

  feature 'show page' do

    before do
      @task = Task.create(
        title: "タスクテスト", 
        body: "タスクテスト本文", 
        status: Task.statuses.key(1), 
        priority: Task.priorities.key(0),
        user_id: @user.id
      )
    end

    scenario 'succeed in task destruction in show page', type: :system do
      visit task_path(id: @task.id)
      click_on I18n.t('buttons.delete')

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content(I18n.t('tasks.index.deleted'))
    end
  end
end
