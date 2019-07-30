class Task < ApplicationRecord
	enum status: { waiting: 0, working: 1, finished: 2}
	validates :title, presence: true
	validates :body, presence: true
	validates :status, presence: true
	default_scope -> { order(created_at: :desc) }
end
