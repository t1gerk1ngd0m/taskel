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
    if params[:title].blank? && params[:status].blank?
      all
    elsif params[:status].empty?
      search_title(params[:title])
    elsif params[:title] && params[:status]
      search_title(params[:title]).search_status(params[:status])
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
