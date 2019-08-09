require 'rails_helper'

describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'validation' do
    context 'name' do
      it "is invalid without a name" do
        user = build(:user, name: "")
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
    end

    context 'email' do
      it "is invalid without a email" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      it "is invalid with a duplicate email address" do
        same_email = "aaaaa@gmail.com"
        user = create(:user, email: same_email)
        another_user = build(:user, email: same_email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end
      it "is invalid with a email not includes @ " do
        user = build(:user, email: "aaaaa")
        user.valid?
        expect(user.errors[:email]).to include("不正なメールアドレスです")
      end
      it "is invalid with a email includes no character before @ " do
        user = build(:user, email: "@aaa.com")
        user.valid?
        expect(user.errors[:email]).to include("不正なメールアドレスです")
      end
      it "is invalid with a email includes no character after @ " do
        user = build(:user, email: "aaaa@")
        user.valid?
        expect(user.errors[:email]).to include("不正なメールアドレスです")
      end
      it "is invalid with a email includes non-alphanumeric characters " do
        user = build(:user, email: "aaあa@aaa.com")
        user.valid?
        expect(user.errors[:email]).to include("不正なメールアドレスです")
      end
    end

    context 'password' do
      it "is invalid without a password" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
      it "is invalid without a password_confirmation although with a password" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
      it "is invalid with a password that has less than 5 characters" do
        pass_chara_five = "aaaaa"
        user = build(:user, password: pass_chara_five, password_confirmation: pass_chara_five)
        user.valid?
        expect(user.errors[:password]).to include("6文字以上の半角英数字で入力してください")
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