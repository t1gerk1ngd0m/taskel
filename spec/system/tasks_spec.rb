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

      fill_in I18n.t('activerecord.attributes.task.title'), with: task.title
      fill_in I18n.t('activerecord.attributes.task.body'), with: task.body
      select task.status_i18n ,from: I18n.t('activerecord.attributes.task.status')

      click_button I18n.t('buttons.create')

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content(I18n.t('tasks.index.saved'))
      expect(page).to ( 
        have_content(task.title) && have_content(task.body) && have_content(task.status_i18n)
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
      @task = Task.create(title: "タスクテスト", body: "タスクテスト本文", status: 1)
    end

    scenario 'succeed in task editation', type: :system do
      visit edit_task_path(id: @task.id)

      fill_in I18n.t('activerecord.attributes.task.title'), with: @task.title
      fill_in I18n.t('activerecord.attributes.task.body'), with: @task.body
      select @task.status ,from: I18n.t('activerecord.attributes.task.status')
      click_button I18n.t('buttons.update')

      expect(page).to have_content("タスク詳細")
      expect(page).to have_content(I18n.t('tasks.show.edited'))
      expect(page).to (
        have_content(@task.title) && have_content(@task.body) && have_content(@task.status_i18n)
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
      priority_array = ['high', 'middle', 'low']
      @task = Task.create(title: "タスクテスト１", body: "タスクテスト本文１", status: 1, deadline: "2019-08-10", priority: priority_array[0])
      @task = Task.create(title: "タスクテスト２", body: "タスクテスト本文２", status: 0, deadline: "2019-08-20", priority: priority_array[1], created_at: Time.current + 1.days)
      @task = Task.create(title: "タスクテスト３", body: "タスクテスト本文３", status: 2, priority: priority_array[2], created_at: Time.current + 2.days)
      @task = Task.create(title: "タスクテスト４", body: "タスクテスト本文４", status: 0, deadline: "2019-08-20", created_at: Time.current + 3.days)
    end

    scenario 'sorted by creation date in default', type: :system do
      visit root_path
      created_at_list = all(".task-index__task--created_at")

      expect(page).to have_content("タスク一覧")

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

      expect(page).to have_content("タスク一覧")

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
      
      expect(page).to have_content("タスク一覧")

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
      
      expect(page).to have_content("タスク一覧")

      4.times do |i|
        if (deadline_list[i+1] && deadline_list[i].text().present?)
          expect(deadline_list[i].text()).to be >= deadline_list[i+1].text()
        end
      end
    end

    scenario 'sorted by priority', type: :system do
      priority_array = ['high', 'middle', 'low']
      visit root_path
      click_on I18n.t('activerecord.attributes.task.priority')
      sleep 1
      priority_list = all(".task-index__task--priority")
      4.times do |i|
        if priority_list[i].text().present?
          binding.pry
          expect(priority_list[i].text()).to have_content I18n.t("enums.task.priority.#{priority_array[2-i]}")
        end
      end

      click_on I18n.t('activerecord.attributes.task.priority')
      sleep 1
      priority_list = all(".task-index__task--priority")
      4.times do |i|
        if priority_list[i].text().present?
          binding.pry
          expect(priority_list[i].text()).to have_content I18n.t("enums.task.priority.#{priority_array[i-1]}")
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

      click_on I18n.t('buttons.delete')

      expect(page).to have_content("タスク一覧")
      expect(page).to have_content(I18n.t('tasks.index.deleted'))
    end
  end
end
