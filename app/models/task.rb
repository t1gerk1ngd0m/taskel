class Task < ApplicationRecord
	enum status: { waiting: 0, working: 1, finished: 2}
	enum priority: { low: 0, middle: 1, high: 2}
	validates :title, presence: true
	validates :body, presence: true
	validates :status, presence: true
	validates :priority, presence: true

	def self.search(title, status)
		# title,status共にblankでないとき（indexページ新規取得時）
		if title.blank? && status.blank?
			all
		# statusで検索しないとき
		elsif status.empty?
			where('title Like(?)', "%#{title}%")
		elsif title && status
			where('(title Like(?)) AND (status = ?)', "%#{title}%", status)
		end
	end
end
