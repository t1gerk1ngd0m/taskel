class Task < ApplicationRecord
	enum status: { waiting: 0, working: 1, finished: 2}
	with_options presence: true do
		validates :title
		validates :body
		validates :status
	end
end
