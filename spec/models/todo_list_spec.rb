require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    it 'have column name' do
      expect(model).to include('name')
    end
  end

  describe '.associations' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe '.validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(200) }
  end
end
