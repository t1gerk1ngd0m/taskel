require 'active_support'

module TaskAlert
  extend ActiveSupport::Concern

  included do
    before_action :set_task_alerts
  end

  private
  def set_task_alerts
    set_group
    @task_alerts = @group.tasks.notice_tasks
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end