class TasksController < ApplicationController

    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def show
        @task = Task.find(params[:id])
    end

    def create
        Task.create(title: task_params[:title], body: task_params[:body], status: task_params[:status])
        flash[:create] = "タスクを作成しました"
        redirect_to root_path
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        @task.update(task_params)
        flash[:update] = "タスクを編集しました"
        redirect_to action: 'show'
    end

    def destroy

    end

    private
    def task_params
        params.require(:task).permit(:title, :body, :status)
    end
end
