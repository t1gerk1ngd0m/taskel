class User < ApplicationRecord
  has_secure_password validations: true
  has_many :tasks

  REG_MAIL_ADDRESS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  REG_PASSWORD = /\A[a-z\d]{6,}+\z/i

  validates :name,
    presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: REG_MAIL_ADDRESS,
              message: I18n.t("errors.users.email")
            }
  validates :password_digest,
    presence: true,
    confirmation: true,
    format: { with: REG_PASSWORD,
              message: I18n.t("errors.users.password")
            }
end
