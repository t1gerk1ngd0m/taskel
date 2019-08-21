class Label < ApplicationRecord
  has_many :labellimgs, dependent: :delete_all
  has_many :tasks, through: :labellings
end
