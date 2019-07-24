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
        binding.pry
        Task.create(title: task_params[:title], body: task_params[:body], status: task_params[:status])
        redirect_to action: 'index'
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        @task.update(task_params)
    end

    def destroy

    end

    private
    def task_params
        params.require(:task).permit(:title, :body, :status)
    end
end
