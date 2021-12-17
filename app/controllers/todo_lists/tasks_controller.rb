module TodoLists
  class TasksController < ApplicationController
    before_action :set_todo_list
    before_action :set_task, only: %i[edit update status_update destroy]

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params.merge(todo_list_id: @todo_list.id))
      if @task.save
        redirect_to todo_list_path(@todo_list), notice: 'Task was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def status_update
      if @task.update(status: params[:status])
        redirect_to redirect_to todo_list_path(@todo_list), notice: 'Task status was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def update
      if @task.update(task_params)
        redirect_to redirect_to todo_list_path(@todo_list), notice: 'Task was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @task.destroy
      redirect_to redirect_to todo_list_path(@todo_list), notice: 'Task was successfully destroyed.'
    end

    private

    def set_todo_list
      @todo_list = TodoList.published.find(params[:todo_list_id])
    end

    def set_task
      @task = @todo_list.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :status)
    end
  end
end
