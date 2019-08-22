require 'rails_helper'

describe Group, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    it "is invalid without a name" do
      group = build(:group, name: "")
      group.valid?
      expect(group.errors[:name]).to include I18n.t('errors.messages.blank')
    end
    # it "is invalid without a users" do
    #   group = build(:group, users: nil)
    #   group.valid?
    #   expect(group.errors[:users]).to include I18n.t('errors.messages.blank')
    # end
    # it "is valid with a name and users" do
    #   group = build(:group)
    #   group.valid?
    #   expect(group).to be_valid
    # end
  end
end
