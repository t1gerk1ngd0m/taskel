require 'rails_helper'

RSpec.describe 'Groups', type: :system do

  before do
    @users = []
    5.times do |n|
      @users << create(:user)
    end

    login(@users[0])
  end

  feature 'new page' do

    given(:group) { build(:group,
      name: "グループ名"
    ) }

    scenario 'succeed in group creation', type: :system do
      visit new_group_path

      fill_in I18n.t('activerecord.attributes.group.name'), with: group.name
      check @users[1].name
      check @users[2].name

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
        users: [@users[0], @users[1], @users[2]]
      )
    end

    scenario 'succeed in group editation', type: :system do
      visit edit_group_path(id: @group.id)

      fill_in I18n.t('activerecord.attributes.group.name'), with: "テストグループ２"
      check @users[3].name
      check @users[4].name
      uncheck @users[1].name
      uncheck @users[2].name

      click_button I18n.t('buttons.update')

      expect(page).to have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.update.success'))
      expect(page).to (
        have_content("テストグループ２") && have_content([@users[3].name, @users[4].name, @users[0].name].join(', '))
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
        users: [@users[0], @users[1], @users[2]]
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
