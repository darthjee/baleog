# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::ValueWrapper do
  describe '.wrap' do
    let(:value) { values.sample }
    let(:values) do
      [Random.rand, 'some string', { key: 10 }, Object.new, Class.new, [2, 3]]
    end

    context 'when klass is nil' do
      it 'returns the value' do
        expect(described_class.wrap(value, nil))
          .to eq(value)
      end
    end

    context 'when class is :string' do
      it 'returns the value as string' do
        expect(described_class.wrap(value, :string))
          .to eq(value.to_s)
      end
    end

    context 'when class is :integer' do
      let(:value) { '10.5' }

      it 'returns the value as integer' do
        expect(described_class.wrap(value, :integer))
          .to eq(10)
      end
    end

    context 'when class is :float' do
      let(:value) { '10.5' }

      it 'returns the value as integer' do
        expect(described_class.wrap(value, :integer))
          .to eq(10)
      end
    end
  end
end