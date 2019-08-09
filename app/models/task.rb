class Task < ApplicationRecord
	# ログイン/ログアウト機能を通すため一旦optional: trueを追加
	belongs_to :user, optional: true
	enum status: { waiting: 0, working: 1, finished: 2}
	enum priority: { low: 0, middle: 1, high: 2}
	validates :title, presence: true
	validates :body, presence: true
	validates :status, presence: true
	validates :priority, presence: true

	def self.search(params)
		# title,status共にblankでないとき（indexページ新規取得時）
		if params[:title].blank? && params[:status].blank?
			all
		# statusで検索しないとき
		elsif params[:status].empty?
			where('title Like(?)', "%#{params[:title]}%")
		elsif params[:title] && params[:status]
			where('(title Like(?)) AND (status = ?)', "%#{params[:title]}%", params[:status])
		end
	end
end
