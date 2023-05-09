class TasksController < ApplicationController
  before_action :find_task, only: [ :update, :show, :destroy, :edit]

  def index
    @task = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      # display the form page again
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @task.update(task_params) # Will raise ActiveModel::ForbiddenAttributesError
    if @task.save
      redirect_to task_path
    else
      # display the form page again
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    # No need for app/views/tasks/destroy.html.erb
    redirect_to tasks_path, status: :see_other
  end

  private

  # strong params -> white listing the info coming from the form
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
