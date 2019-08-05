class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  # helperが呼び出せるようにする
  # application_helper以外でもここに書けば呼び出せる？
  helper_method :sort_column, :sort_direction

  def index
    @tasks = Task.search(params[:title], params[:status]).order("tasks.#{sort_column} #{sort_direction}")
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

  # def search
  #   if params[:status].blank?
  #     @tasks = Task.where('title LIKE(?)', "%#{params[:title]}%")
  #   else
  #     @tasks = Task.where('(title LIKE(?)) AND (status = ?)', "%#{params[:title]}%", params[:status])
  #   end
  # end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status, :deadline, :file, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  # パラメーターとしてasc or descを返す
  def sort_direction
    # %w[asc desc]の意味は？
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  # ソートするカラムを選択する。最初はcreated_at
  # column_namesメソッド
  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
