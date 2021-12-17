require 'rails_helper'

RSpec.describe 'TodoLists', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get todo_lists_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_todo_list_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when success and redirect' do
      let(:attributes) do
        {
          todo_list: {
            name: Faker::Lorem.sentence
          }
        }
      end
      it 'when redirect' do
        post todo_lists_path, params: attributes
        expect(response).to redirect_to todo_list_tasks_path(todo_list_id: TodoList.last.id)
      end

      it 'when count by 1' do
        expect do
          post todo_lists_path, params: attributes
        end.to change(TodoList, :count).by(1)
      end
    end

    context 'when fail and render new' do
      let(:attributes) do
        {
          todo_list: {
            name: ''
          }
        }
      end
      before do
        post todo_lists_path, params: attributes
      end
      it do
        expect(response).to render_template(:new)
      end

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /edit' do
    let(:todo_list) { create(:todo_list) }
    it 'returns http success' do
      get edit_todo_list_path(todo_list)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    let(:todo_list) { create(:todo_list) }
    let(:name) { Faker::Lorem.sentence }
    context 'when accepted' do
      let(:attributes) do
        {
          todo_list: {
            name: name
          }
        }
      end

      it 'change name' do
        expect  do
          put todo_list_path(todo_list), params: attributes
        end.to change { todo_list.reload.name }.to(name)
      end

      it 'redirect to todo_lists' do
        put todo_list_path(todo_list), params: attributes
        expect(response).to redirect_to todo_list_tasks_path(todo_list_id: todo_list.id)
      end
    end

    context 'when fail' do
      let(:attributes) do
        {
          todo_list: {
            name: ''
          }
        }
      end

      it 'returns http unprocessable_entity' do
        put todo_list_path(todo_list), params: attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'render template edit' do
        put todo_list_path(todo_list), params: attributes
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:todo_list) { create(:todo_list) }
    context 'when delete successed' do
      it 'redirect to todo_lists' do
        delete todo_list_path(todo_list)
        expect(response).to redirect_to todo_lists_path
      end

      it 'change count by -1' do
        expect do
          delete todo_list_path(todo_list)
        end.to change(TodoList, :count).by(0)
      end
    end
  end
end
