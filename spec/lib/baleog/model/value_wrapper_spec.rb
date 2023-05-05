# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::ValueWrapper do
  subject(:wrapper_class) { base_model_class::ValueWrapper }

  let(:base_model_class) { Class.new(Baleog::Model) }

  describe '.cast' do
    let(:value) { values.sample }
    let(:values) do
      [Random.rand, 'some string', { key: 10 }, Object.new, Class.new, [2, 3]]
    end

    context 'when klass is nil' do
      it 'returns the value' do
        expect(wrapper_class.cast(value, nil))
          .to eq(value)
      end
    end

    context 'when key is :string' do
      it 'returns the value as string' do
        expect(wrapper_class.cast(value, :string))
          .to eq(value.to_s)
      end
    end

    context 'when key is :integer' do
      let(:value) { '10.5' }

      it 'returns the value as integer' do
        expect(wrapper_class.cast(value, :integer))
          .to eq(10)
      end
    end

    context 'when key is :float' do
      let(:value) { '10.5' }

      it 'returns the value as float' do
        expect(wrapper_class.cast(value, :float))
          .to eq(10.5)
      end
    end

    context 'when key is a model class' do
      let(:model_class) { Class.new(base_model_class) }
      let(:value)       { { key: :value } }

      it do
        expect(wrapper_class.cast(value, model_class, klass: model_class))
          .to be_a(model_class)
      end

      it 'initializes the model with the correct value' do
        expect(wrapper_class.cast(value, model_class, klass: model_class))
          .to eq(model_class.new(value))
      end
    end
  end
end
