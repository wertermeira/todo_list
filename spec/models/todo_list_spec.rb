require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name status].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  describe '.validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(200) }
    it { is_expected.to define_enum_for(:status).with_values({ active: 0, filed: 1 }).with_prefix(:status) }
  end
end
