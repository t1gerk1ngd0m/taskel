require 'rails_helper'

RSpec.describe 'Groups', type: :system do

  before do
    @user = []
    10.times do |n|
      @user << create(:user)
    end
    login(@user[0])
  end

  feature 'new page' do

    given(:group) { build(:group,
      name: "グループ名"
    ) }

    scenario 'succeed in group creation', type: :system do
      visit new_group_path

      fill_in I18n.t('activerecord.attributes.group.name'), with: group.name
      check @user[1].name
      check @user[2].name

      click_button I18n.t('buttons.create')

      expect(page).to have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.create.success'))
      expect(page).to ( 
        have_content(group.name) && have_content(group.users.pluck(:name).join(', '))
      )
    end

    scenario 'fail in group creation', type: :system do
      visit new_group_path

      click_button I18n.t('buttons.create')

      expect(page).to_not have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.create.failed'))
    end
  end

  feature 'edit page' do

    before do
      @group = create(:group,
        name: "テストグループ", 
        users: [@user[1], @user[2]],
        owner_user: @user[0]
      )
    end

    scenario 'succeed in group editation', type: :system do
      visit edit_group_path(id: @group.id)

      fill_in I18n.t('activerecord.attributes.group.name'), with: "テストグループ２"
      check @user[3].name
      check @user[4].name
      uncheck @user[1].name
      uncheck @user[2].name

      click_button I18n.t('buttons.update')

      expect(page).to have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.update.success'))
      expect(page).to (
        have_content("テストグループ２") && have_content([@user[3].name, @user[4].name, @user[0].name].join(', '))
      )
    end

    scenario 'fail in group editation', type: :system do
      visit edit_group_path(id: @group.id)

      fill_in I18n.t('activerecord.attributes.group.name'), with: ""
      click_button I18n.t('buttons.update')

      expect(page).to_not have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.update.failed'))
    end
  end

  feature 'index page' do

    before do
      @group = create(:group,
        name: "テストグループ", 
        users: [@user[1], @user[2]],
        owner_user: @user[0]
      )
    end

    scenario 'succeed in group destruction', type: :system do
      visit root_path

      click_on I18n.t('buttons.delete')

      expect(page).to have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.destroy.success'))
    end
  end
end
