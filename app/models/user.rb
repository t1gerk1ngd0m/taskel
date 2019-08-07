class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  reg_mail_address = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  reg_mail_password = /\A[a-z\d]{6,}+\z/i

  validates :name,
    presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: reg_mail_address,
              message: I18n.t("errors.users.email")
            }
  validates :password_digest,
    presence: true,
    confirmation: true,
    format: { with: reg_mail_password,
              message: I18n.t("errors.users.password")
            }
end
