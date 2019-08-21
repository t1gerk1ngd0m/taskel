class Task < ApplicationRecord
  has_many :task_labels, dependent: :delete_all
  has_many :labels, through: :task_labels
  belongs_to :user
  enum status: { waiting: 0, working: 1, finished: 2}
  enum priority: { low: 0, middle: 1, high: 2}
  validates :title, presence: true
  validates :body, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  def self.search(params)
    search_record = self.all
    search_record = search_record.search_title(params[:title]) if params[:title].present?
    search_record = search_record.search_status(params[:status]) if params[:status].present?
    search_record = search_record.search_label(params[:label_id]) if params[:label_id].present?
    search_record
  end

  def self.notice_tasks
    self.not_completed_tasks.near_deadline_tasks
  end

  private
  def self.search_title(title)
    where('title Like(?)', "%#{title}%")
  end

  def self.search_status(status)
    where('status = ?', status)
  end

  def self.search_label(label_id)
    joins(:labels).where('labels.id = ?', label_id)
  end

  def self.not_completed_tasks
    self.where('status != ?', 2)
  end

  def self.near_deadline_tasks
    self.where('deadline <= ?', Time.zone.today+1)
  end
end
