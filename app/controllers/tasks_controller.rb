class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.search_by_title(params[:title])
                 .search_by_description(params[:description])
                 .sort_by_completed_at(params[:completed_at])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_param)
    return redirect_to :action => 'index' if @task.save
    @errors = @task.errors.full_messages
    render :action => 'new', status: 422
  end

  def show; end

  def edit
    render :action => 'new'
  end

  def update
    return redirect_to :action => 'index' if @task.update(task_param)
    @errors = @task.errors.full_messages
    render :action => 'edit', status: 422
  end

  def destroy
    return redirect_to :action => 'index' if @task.destroy
    @errors = @task.errors.full_messages
    render :action => 'edit', status: 422
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def task_param
    params.require(:task).permit(:title, :description, :completed_at, :status, :user_id)
  end
end
