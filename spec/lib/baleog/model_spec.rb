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

    context 'when symbol keys are  given' do
      it do
        expect { model_class.new(hash) }
          .not_to raise_error
      end
    end

    context 'when string keys are  given' do
      it do
        expect { model_class.new(hash.stringify_keys) }
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

  describe '.as_json' do
    let(:stringified_hash) { JSON.parse(hash.to_json) }
    let(:changed_hash)     { {} }
    let(:expected_hash) do
      stringified_hash.merge(JSON.parse(changed_hash.to_json))
    end
    let(:hash) do
      {
        name: 'Person name',
        address: {
          street: 'Some street',
          number: '10 A'
        },
        info: {
          tag: 'tag'
        }
      }
    end

    let(:address_class) do
      Class.new(described_class) do
        fields :street, :number
      end
    end

    let(:model_class) do
      address = address_class

      Class.new(described_class) do
        field :name
        field :address, cast: address
        field :info
      end
    end

    context 'when nothing was updated' do
      it 'returns the hash itself' do
        expect(model.as_json).to eq(expected_hash)
      end
    end

    context 'when a plain field is updated' do
      let(:changed_hash) do
        { name: 'New Name' }
      end

      before { model.name = 'New Name' }

      it 'returns the hash with the new calue' do
        expect(model.as_json).to eq(expected_hash)
      end
    end

    context 'when a class wrapped field is updated with a hash' do
      let(:new_address) { { street: 'New street', number: 'new number' } }
      let(:changed_hash) do
        { address: new_address }
      end

      before { model.address = new_address }

      it 'returns the hash with the new calue' do
        expect(model.as_json).to eq(expected_hash)
      end
    end

    context 'when a class wrapped field is updated with an object' do
      let(:new_address) { { street: 'New street', number: 'new number' } }
      let(:changed_hash) do
        { address: new_address }
      end

      before do
        model.address = address_class.new(new_address)
      end

      it 'returns the hash with the new calue' do
        expect(model.as_json).to eq(expected_hash)
      end
    end
  end
end
