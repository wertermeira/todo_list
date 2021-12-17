require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name status todo_list_id].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  describe '.associations' do
    it { is_expected.to belong_to(:todo_list) }
  end

  describe '.validation' do
    let(:status) do
      { todo: 0, doing: 1, done: 2 }
    end
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(200) }
    it { is_expected.to validate_presence_of(:status).on(:update) }
    it { is_expected.to define_enum_for(:status).with_values(status).with_prefix(:status) }
  end
end
