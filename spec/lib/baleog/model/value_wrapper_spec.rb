# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::ValueWrapper do
  describe '.wrap' do
    context 'when klass is nil' do
      let(:value) { values.sample }
      let(:value) do
        [Random.rand, 'some string', { key: 10 }, Object.new, Class.new, [2, 3]]
      end

      it 'returns the value' do
        expect(described_class.wrap(value, nil))
          .to eq(value)
      end
    end
  end
end
