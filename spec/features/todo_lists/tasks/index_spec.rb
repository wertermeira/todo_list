require 'rails_helper'

describe 'Task #index', type: :feature do
  let(:todo_list) { create(:todo_list) }

  describe '.page' do
    context 'when count tasks' do
      let(:tasks_count) { rand(1..10) }
      before do
        create_list(:task, tasks_count, todo_list: todo_list)
      end
      it 'returns http success' do
        visit todo_list_tasks_path(todo_list_id: todo_list.id)
        expect(page.all('tbody tr').size).to eq(tasks_count)
      end
    end

    context 'when link in new task' do
      it do
        visit todo_list_tasks_path(todo_list_id: todo_list.id)
        click_link 'Add task'
        expect(page).to have_current_path(new_todo_list_task_path(todo_list_id: todo_list.id))
      end
    end
  end
end
