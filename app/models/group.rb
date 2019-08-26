class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :tasks, dependent: :destroy
  has_one :owner_group_user, -> {where(owner: true)}, class_name: 'GroupUser'
  has_one :owner_user, through: :owner_group_user, source: :user
  accepts_nested_attributes_for :group_users, allow_destroy: true
  validates :name, presence: true
  validates :users, presence: true
end
