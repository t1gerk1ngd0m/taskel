class Task < ApplicationRecord
	enum status: { waiting: 0, working: 1, finished: 2}
	enum priority: { low: 0, middle: 1, high: 2}
	validates :title, presence: true
	validates :body, presence: true
	validates :status, presence: true
end
