class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[edit update destroy]

  def index
    @q = TodoList.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @todo_lists = @q.result.page(params[:page]).per(params[:size])
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      redirect_to todo_list_tasks_path(todo_list_id: @todo_list.id), notice: 'TodoList was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_list_tasks_path(todo_list_id: @todo_list.id), notice: 'TodoList was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_path, notice: 'TodoList was successfully destroyed.'
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end
