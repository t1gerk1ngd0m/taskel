require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  feature 'login page' do
    before do
      @user = create(:user)
    end

    scenario 'succeed in login', type: :system do
      login(@user)
      expect(page).to have_content("タスク一覧")
      expect(page).to have_content(I18n.t('sessions.login.success'))
      expect(page).to have_content(@user.name)
    end

    scenario 'fail in login', type: :system do
      visit login_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: @user.password
      fill_in I18n.t('activerecord.attributes.user.password'), with: ""
      click_button I18n.t('buttons.login')

      expect(page).to have_content("ログイン画面")
      expect(page).to have_content(I18n.t('sessions.login.failed'))
    end
  end

  feature 'logout' do
    before do
      @user = create(:user)
      login(@user)
    end

    scenario 'succeed in logout', type: :system do
      visit root_path
      click_on I18n.t('buttons.logout')
      
      expect(page).to have_content("ログイン画面")
      expect(page).to have_content(I18n.t('sessions.logout.success'))
    end
  end
end
