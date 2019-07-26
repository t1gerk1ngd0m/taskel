class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:saved] = t 'tasks.index.saved'
      redirect_to root_path
    else
      flash[:save_failed] = t 'tasks.new.save_failed'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:edited] = t 'tasks.show.edited'
      redirect_to action: 'show'
    else
      flash[:edit_failed] = t 'tasks.edit.edit_failed'
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:deleted] = t 'tasks.index.deleted'
      redirect_to root_path      
    else
      flash[:delete_failed] = t 'tasks.show.delete_failed'
      render :show
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
