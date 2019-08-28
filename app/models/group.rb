class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :users, presence: true
end
