require 'active_support'

module TaskAlert
  extend ActiveSupport::Concern

  included do
    before_action :set_task_alerts
  end

  private
  def set_task_alerts
    # binding.pry
    @task_alerts = current_user.tasks.notice_tasks
  end
end