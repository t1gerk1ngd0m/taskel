require 'active_support'

module TaskAlert
  extend ActiveSupport::Concern

  included do
    before_action :set_task_alerts
  end

  private
  def set_task_alerts
    @task_alerts = @group.tasks.notice_tasks
  end
end
