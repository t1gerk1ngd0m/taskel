class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :tasks, dependent: :destroy
  has_one :owner_group_user, -> {where(owner: true)}, class_name: 'GroupUser'
  has_one :owner_user, through: :owner_group_user, source: :user
  validates :name, presence: true
  validates :users, presence: true
end
