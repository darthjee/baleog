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

      context 'when the it is initialized with a hash with symbol for keys' do
        it 'returns the value from the hash' do
          expect(model.key).to eq(:value)
        end
      end

      context 'when the it is initialized with a hash with strings for keys' do
        let(:hash) { { 'key' => :value } }

        it 'returns the value from the hash' do
          expect(model.key).to eq(:value)
        end
      end

      context 'when the it is initialized with nothing' do
        let(:model) { model_class.new }

        it { expect(model.key).to be_nil }
      end
    end
  end

  describe 'writter method call' do
    context 'when no options were given when generating the field' do
      before do
        model_class.field(:key)
      end

      context 'when the it is initialized with a hash with symbol for keys' do
        it 'returns the new value' do
          expect(model.key = :new_value).to eq(:new_value)
        end

        it 'changes the value from the reader' do
          expect { model.key = :new_value }
            .to change(model, :key)
            .from(:value).to(:new_value)
        end
      end

      context 'when the it is initialized with a hash with strings for keys' do
        let(:hash) { { 'key' => :value } }

        it 'returns the new value' do
          expect(model.key = :new_value).to eq(:new_value)
        end

        it 'changes the value from the reader' do
          expect { model.key = :new_value }
            .to change(model, :key)
            .from(:value).to(:new_value)
        end
      end

      context 'when the it is initialized with nothing' do
        let(:model) { model_class.new }

        it 'returns the new value' do
          expect(model.key = :new_value).to eq(:new_value)
        end

        it 'changes the value from the reader' do
          expect { model.key = :new_value }
            .to change(model, :key)
            .from(nil).to(:new_value)
        end
      end
    end
  end
end
