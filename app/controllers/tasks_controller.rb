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
			binding.pry
			flash[:saved] = t 'tasks.index.saved'
			redirect_to root_path
		else
			flash[:save_failed] = t 'tasks.index.save_failed'
			render :new
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		if @task.update(task_params)
			flash[:edited] = t 'tasks.index.edited'
			redirect_to action: 'show'
		else
			flash[:edit_failed] = t 'tasks.index.edit_failed'
			render :edit
		end
	end

	def destroy
		@task = Task.find(params[:id])
		if @task.destroy
			flash[:deleted] = t 'tasks.index.deleted'
			redirect_to root_path      
		else
			flash[:delete_failed] = t 'tasks.index.delete_failed'
			render :show
		end
	end

	private
	def task_params
		params.require(:task).permit(:title, :body, :status)
	end
end
