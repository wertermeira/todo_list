require 'rails_helper'

RSpec.describe TodoLists::TasksHelper, type: :helper do
  describe '.class_btn_status' do
    context 'when status' do
      it 'returns class btn-success' do
        expect(helper.class_btn_status('done')).to eq('btn btn-sm btn-success')
      end

      it 'returns class btn-danger' do
        expect(helper.class_btn_status('todo')).to eq('btn btn-sm btn-danger')
      end

      it 'returns class btn-warning' do
        expect(helper.class_btn_status('doing')).to eq('btn btn-sm btn-warning')
      end
    end
  end

  describe '.statics_tasks' do
    context 'when status without todolist' do
      it 'returns content_tag span done' do
        helper_statics = helper.statics_tasks(status: 'done')
        expect(helper_statics).to eq('<span class="btn btn-sm btn-success">0 tasks in done</span>')
      end

      it 'returns content_tag span todo' do
        helper_statics = helper.statics_tasks(status: 'todo')
        expect(helper_statics).to eq('<span class="btn btn-sm btn-danger">0 tasks in todo</span>')
      end

      it 'returns content_tag span doing' do
        helper_statics = helper.statics_tasks(status: 'doing')
        expect(helper_statics).to eq('<span class="btn btn-sm btn-warning">0 tasks in doing</span>')
      end
    end

    context 'when status with todolist' do
      let(:todo_list) { create(:todo_list) }

      it 'returns content_tag span done' do
        helper_statics = helper.statics_tasks(todo_list: todo_list, status: 'done')
        expect(helper_statics).to eq('<span class="btn btn-sm btn-success">0 tasks in done</span>')
      end

      it 'returns content_tag span todo' do
        helper_statics = helper.statics_tasks(todo_list: todo_list, status: 'todo')
        expect(helper_statics).to eq('<span class="btn btn-sm btn-danger">0 tasks in todo</span>')
      end

      it 'returns content_tag span doing' do
        helper_statics = helper.statics_tasks(todo_list: todo_list, status: 'doing')
        expect(helper_statics).to eq('<span class="btn btn-sm btn-warning">0 tasks in doing</span>')
      end
    end
  end
end
