require 'rails_helper'

RSpec.describe 'TodoLists::Tasks', type: :request do
  let(:todo_list) { create(:todo_list) }

  describe 'GET /index' do
    it 'returns http success' do
      get todo_list_tasks_path(todo_list_id: todo_list.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_todo_list_task_path(todo_list_id: todo_list.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when success and redirect' do
      let(:attributes) do
        {
          task: {
            name: Faker::Lorem.sentence
          }
        }
      end
      it 'when redirect' do
        post todo_list_tasks_path(todo_list_id: todo_list.id), params: attributes
        expect(response).to redirect_to todo_list_tasks_path(todo_list_id: todo_list.id)
      end

      it 'when count by 1' do
        expect do
          post todo_list_tasks_path(todo_list_id: todo_list.id), params: attributes
        end.to change(Task, :count).by(1)
      end
    end

    context 'when fail and render new' do
      let(:attributes) do
        {
          task: {
            name: ''
          }
        }
      end
      before do
        post todo_list_tasks_path(todo_list_id: todo_list.id), params: attributes
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
    let(:task) { create(:task, todo_list: todo_list) }
    it 'returns http success' do
      get edit_todo_list_task_path(todo_list_id: todo_list.id, id: task.id)
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found' do
      get edit_todo_list_task_path(todo_list_id: todo_list.id, id: '0')
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PUT /update' do
    let(:task) { create(:task, todo_list: todo_list) }
    let(:name) { Faker::Lorem.sentence }
    context 'when accepted' do
      let(:attributes) do
        {
          task: {
            name: name
          }
        }
      end

      it 'change name' do
        expect  do
          put todo_list_task_path(todo_list_id: todo_list.id, id: task.id), params: attributes
        end.to change { task.reload.name }.to(name)
      end

      it 'redirect to todo_lists' do
        put todo_list_task_path(todo_list_id: todo_list.id, id: task.id), params: attributes
        expect(response).to redirect_to todo_list_tasks_path(todo_list_id: todo_list.id)
      end
    end

    context 'when fail' do
      let(:attributes) do
        {
          task: {
            name: ''
          }
        }
      end

      it 'returns http unprocessable_entity' do
        put todo_list_task_path(todo_list_id: todo_list.id, id: task.id), params: attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'render template edit' do
        put todo_list_task_path(todo_list_id: todo_list.id, id: task.id), params: attributes
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'Status update /update_status' do
    let(:task) { create(:task, todo_list: todo_list) }
    let(:status) { Task::STATUSES.keys.map(&:to_s).sample }
    context 'when accepted' do
      before do
        put status_update_todo_list_task_path(todo_list_id: todo_list.id, id: task.id, status: status)
      end
      it 'change status' do
        expect(task.reload.status).to eq(status)
      end

      it 'redirect to todo_list' do
        expect(response).to redirect_to todo_list_tasks_path(todo_list_id: todo_list.id)
      end
    end

    context 'when fail' do
      it 'return flash alert' do
        put status_update_todo_list_task_path(todo_list_id: todo_list.id, id: task.id, status: 'invalid_status')
        expect(flash[:alert]).to match(/'invalid_status' is not a valid status/)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:task) { create(:task, todo_list: todo_list) }
    it 'redirect to todo_lists' do
      delete todo_list_task_path(todo_list_id: todo_list.id, id: task.id)
      expect(response).to redirect_to todo_list_tasks_path(todo_list_id: todo_list.id)
    end

    it 'count by -1' do
      expect do
        delete todo_list_task_path(todo_list_id: todo_list.id, id: task.id)
      end.to change(Task, :count).by(0)
    end
  end
end
