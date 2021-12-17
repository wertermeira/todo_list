require 'rails_helper'

describe 'TodoList #new', type: :feature do
  let(:todo_list) { create(:todo_list) }

  describe '.page' do
    context 'when create new todo_list' do
      let(:name) { Faker::Lorem.sentence }
      before do
        visit new_todo_list_path
        within('form') do
          fill_in 'todo_list_name', with: name
          click_button
        end
      end
      it 'redirects to tasks' do
        expect(page).to have_current_path(todo_list_tasks_path(todo_list_id: TodoList.last.id))
      end

      it 'find todo_list name' do
        expect(page).to have_content(name)
      end
    end

    context 'when fail edit todo_list' do
      let(:todo_list) { create(:todo_list) }
      before do
        visit new_todo_list_path
        within('form') do
          fill_in 'todo_list_name', with: ''
          click_button
        end
      end
      it do
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
