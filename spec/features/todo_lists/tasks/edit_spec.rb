require 'rails_helper'

describe 'Task #edit', type: :feature do
  let(:todo_list) { create(:todo_list) }

  describe '.page' do
    context 'when edit task' do
      let(:task) { create(:task, todo_list: todo_list) }
      let(:name) { Faker::Lorem.sentence }
      before do
        visit edit_todo_list_task_path(todo_list_id: todo_list.id, id: task.id)
        within('form') do
          fill_in 'task_name', with: name
          click_button
        end
      end
      it 'redirects to tasks' do
        expect(page).to have_current_path(todo_list_tasks_path(todo_list_id: todo_list.id))
      end

      it 'name changed' do
        expect(task.reload.name).to eq(name)
      end
    end

    context 'when fail edit task' do
      let(:task) { create(:task, todo_list: todo_list) }
      before do
        visit edit_todo_list_task_path(todo_list_id: todo_list.id, id: task.id)
        within('form') do
          fill_in 'task_name', with: ''
          click_button
        end
      end
      it do
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
