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
        @task = Task.new(task_params)
        if @task.save
            flash[:notice] = "タスクを作成しました"
            redirect_to root_path
        else
            flash[:notice] = "タスクの作成に失敗しました"
            render :new
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:notice] = "タスクを編集しました"
            redirect_to action: 'show'
        else
            flash[:notice] = "タスクの編集に失敗しました"
            render :edit
        end
    end

    def destroy
        @task = Task.find(params[:id])
        if @task.destroy
            flash[:notice] = "タスクを削除しました"
            redirect_to root_path      
        else
            flash[:notice] = "タスクの削除に失敗しました"
            render :show
        end
    end

    private
    def task_params
        params.require(:task).permit(:title, :body, :status)
    end
end
