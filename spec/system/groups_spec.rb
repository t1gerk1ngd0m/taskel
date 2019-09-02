require 'rails_helper'

RSpec.describe 'Groups', type: :system do

  before do
    @users = []
    5.times do |n|
      @users << create(:user)
    end

    @owner = @users[0]
    @member1 = @users[1]
    @member2 = @users[2]
    @alt_member1 = @users[3]
    @alt_member2 = @users[4]

    login(@owner)
  end

  feature 'new page' do

    given(:group) { build(:group,
      name: "グループ名"
    ) }

    scenario 'succeed in group creation', type: :system do
      visit new_group_path

      fill_in I18n.t('activerecord.attributes.group.name'), with: group.name
      check @member1.name
      check @member2.name

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
        users: [@member1, @member2],
        owner_user: @owner
      )
    end

    scenario 'succeed in group editation', type: :system do
      visit edit_group_path(id: @group.id)

      fill_in I18n.t('activerecord.attributes.group.name'), with: "テストグループ２"
      check @alt_member1.name
      check @alt_member2.name
      uncheck @member1.name
      uncheck @member2.name

      click_button I18n.t('buttons.update')

      expect(page).to have_content("グループ一覧画面")
      expect(page).to have_content(I18n.t('groups.update.success'))
      expect(page).to (
        have_content("テストグループ２") && have_content([@alt_member1.name, @alt_member2.name, @owner.name].join(', '))
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
        users: [@member1, @member2],
        owner_user: @owner
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
