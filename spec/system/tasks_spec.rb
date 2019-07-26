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

    scenario 'succeeded in task creation', type: :system do
      visit new_task_path
      fill_in 'task_title', with: task.title
      fill_in 'task_body', with: task.body
      select task.status ,from: 'task_status'

      click_button '作成する'
      binding.pry
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to be_present
    end
  end

  # all('a').map { |link| link[:href] }.reject{ |url| url.nil? }.each do |url|
  #   visit url
  #   expect(page).to have_http_status(:success)
  # end


end