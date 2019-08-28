class TasksController < ApplicationController
  include TaskAlert
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_group
  before_action :require_maker, only: [:destroy]
  before_action :require_member, only: [:edit, :update, :show]
  helper_method :sort_column, :sort_direction

  def index
    @tasks = @group.tasks.search(search_params).order("tasks.#{sort_column} #{sort_direction}").page(params[:page])
  end

  def new
    @task = @group.tasks.build
  end

  def show
  end

  def create
    @task = @group.tasks.build(task_params)
    if @task.save
      flash[:success] = t 'tasks.index.saved'
      redirect_to group_tasks_path(@group)
    else
      flash[:failed] = t 'tasks.new.save_failed'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(update_task_params)
      flash[:success] = t 'tasks.show.edited'
      redirect_to action: 'show'
    else
      flash[:failed] = t 'tasks.edit.edit_failed'
      render :edit
    end
  end

  def destroy
    if  @task.destroy
      flash[:success] = t 'tasks.index.deleted'
      redirect_to group_tasks_path(@group)
    else
      flash[:failed] = t 'tasks.show.delete_failed'
      render :show
    end
  end

  private
  def task_params
    params.require(:task).permit(
      :title, 
      :body, 
      :status, 
      :deadline, 
      :priority,
      { label_ids: [] }
    ).merge(user_id: current_user.id)
  end

  def update_task_params
    p = params.require(:task).permit(
      :title, 
      :body, 
      :status, 
      :deadline, 
      :priority,
      { label_ids: [] }
    )
    p.except(:status) unless @task.user == current_user
    p
  end

  def search_params
    params.permit(:title, :status, :label_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def require_maker
    set_group
    set_task
    unless current_user == @task.user
      flash[:failed] = t 'tasks.role.failed'
      render :show
    end
  end

  def require_member
    set_group
    set_task
    unless (@group.users.any? {|n| n == current_user})
      flash[:failed] = t 'tasks.role.failed'
      redirect_to root_path
    end
  end
end
