class Task < ApplicationRecord
	enum status: { waiting: 0, working: 1, finished: 2}
	validates :title, presence: true
	validates :body, presence: true
	validates :status, presence: true

	def self.search(title, status)
		if title.blank? && status.blank?
			all
		elsif status.empty?
			search_title(title)
		elsif title && status
			search_title(title).search_status(status)
		end
	end

	private
	def self.search_title(title)
		where('title Like(?)', "%#{title}%")
	end
	
	def self.search_status(status)
		where('status = ?', status)
	end
end
