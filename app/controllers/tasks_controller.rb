class TasksController < ApplicationController
  include TaskAlert
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @tasks = current_user.tasks.search(search_params).order("tasks.#{sort_column} #{sort_direction}").page(params[:page])
  end

  def new
    @task = Task.new
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = t 'tasks.index.saved'
      redirect_to root_path
    else
      flash[:failed] = t 'tasks.new.save_failed'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = t 'tasks.show.edited'
      redirect_to action: 'show'
    else
      flash[:failed] = t 'tasks.edit.edit_failed'
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = t 'tasks.index.deleted'
      redirect_to root_path
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

  def search_params
    params.permit(:title, :status, :label_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
