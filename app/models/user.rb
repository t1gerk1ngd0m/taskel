class User < ApplicationRecord
  has_secure_password validations: true
  has_many :tasks, dependent: :delete_all

  enum role: { user: 0, admin: 1 }

  REG_MAIL_ADDRESS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  REG_PASSWORD = /\A[a-z\d]{6,}+\z/i

  validates :name,
    presence: true
  validates :email,
    presence: true,
    uniqueness: { allow_blank: true },
    format: { with: REG_MAIL_ADDRESS,
              message: I18n.t("errors.users.email"),
              allow_blank: true
            }
  validates :password,
    presence: true,
    confirmation: true,
    format: { with: REG_PASSWORD,
              message: I18n.t("errors.users.password"),
              allow_blank: true
            },
    allow_nil: true

  before_destroy :last_admin_user_destroy
  validate :last_admin_user_edit, on: :update


  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  private
  def last_admin_user_destroy
    if admin_user_last_one? && admin?
      errors.add(:base, I18n.t("errors.base.admin"))
      throw :abort
    end
  end

  def last_admin_user_edit
    if admin_user_last_one? && role_changed?
      errors.add(:base, I18n.t("errors.base.admin"))
      throw :abort
    end
  end

  def admin_user_last_one?
    User.all.admin.count == 1
  end

  def role_change(admin, user)
  end
end
