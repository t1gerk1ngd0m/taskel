class Label < ApplicationRecord
  has_many :labellimgs, dependent: :destroy
  has_many :tasks, through: :labellings
end
