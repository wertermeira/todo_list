require 'rails_helper'

describe 'TodoList #index', type: :feature do
  describe '.page' do
    context 'when count todo_lists' do
      let(:todo_lists_count) { rand(1..10) }
      before do
        create_list(:todo_list, todo_lists_count)
      end
      it 'returns http success' do
        visit todo_lists_path
        expect(page.all('tbody tr').size).to eq(todo_lists_count)
      end
    end

    context 'when link in new todo_list' do
      it do
        visit todo_lists_path
        click_link 'Add TodoList'
        expect(page).to have_current_path(new_todo_list_path)
      end
    end
  end
end
