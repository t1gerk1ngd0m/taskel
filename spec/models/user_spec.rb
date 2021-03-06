require 'rails_helper'

describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'validation' do
    context 'name' do
      it "is invalid without a name" do
        user = build(:user, name: "")
        user.valid?
        expect(user.errors[:name]).to include I18n.t('errors.messages.blank')
      end
    end

    context 'email' do
      it "is invalid without a email" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include I18n.t('errors.messages.blank')
      end
      it "is invalid with a duplicate email address" do
        same_email = "aaaaa@gmail.com"
        user = create(:user, email: same_email)
        another_user = build(:user, email: same_email)
        another_user.valid?
        expect(another_user.errors[:email]).to include I18n.t('errors.messages.uniqueness')
      end
      it "is invalid with a email not includes @ " do
        user = build(:user, email: "aaaaa")
        user.valid?
        expect(user.errors[:email]).to include I18n.t('errors.users.email')
      end
    end

    context 'password' do
      it "is invalid without a password" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include I18n.t('errors.messages.blank')
      end
      it "is invalid without a password_confirmation although with a password" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include I18n.t('errors.users.confirmation')
      end
      it "is invalid with a password that has less than 5 characters" do
        pass_chara_five = "aaaaa"
        user = build(:user, password: pass_chara_five, password_confirmation: pass_chara_five)
        user.valid?
        expect(user.errors[:password]).to include I18n.t('errors.users.password')
      end
    end

    context 'succeed in validation' do
      it "is valid with a name, email, password, password_confirmation" do
        pass_chara_six = "aaaaaa"
        user = build(:user, password: pass_chara_six, password_confirmation: pass_chara_six)
        user.valid?
        expect(user).to be_valid
      end
    end
  end
end