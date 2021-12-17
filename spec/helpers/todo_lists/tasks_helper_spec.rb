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
    context 'when status' do
      it 'returns content_tag span' do
        expect(helper.statics_tasks('done')).to eq('<span class="btn btn-sm btn-success">0 tasks in done</span>')
      end

      it 'returns content_tag span' do
        expect(helper.statics_tasks('todo')).to eq('<span class="btn btn-sm btn-danger">0 tasks in todo</span>')
      end

      it 'returns content_tag span' do
        expect(helper.statics_tasks('doing')).to eq('<span class="btn btn-sm btn-warning">0 tasks in doing</span>')
      end
    end
  end
end
