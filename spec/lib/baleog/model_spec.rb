# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model do
  let(:model_class) { Class.new(described_class) }
  let(:hash)        { { key: :value } }
  let(:model)       { model_class.new(hash) }

  describe '#initialize' do
    context 'when no argument is given' do
      it { expect { model_class.new }.not_to raise_error }
    end

    context 'when a hash is given' do
      it do
        expect { model_class.new(hash) }
          .not_to raise_error
      end
    end

    context 'when a json is given' do
      it do
        expect { model_class.new(hash.to_json) }
          .not_to raise_error
      end
    end
  end

  describe 'reader method call' do
    context 'when no options were given when generating the field' do
      before do
        model_class.field(:key)
      end

      context 'when the model is initialized with a hash with symbol for keys' do
        it 'returns the value from the hash' do
          expect(model.key).to eq(:value)
        end
      end

      context 'when the model is initialized with a hash with strings for keys' do
        let(:hash) { { "key" => :value } }

        it 'returns the value from the hash' do
          expect(model.key).to eq(:value)
        end
      end
    end
  end
end
