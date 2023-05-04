# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::FieldOptions do
  subject(:options) { described_class.new(**options_hash) }

  let(:field_name) { :field_name }

  describe '#klass' do
    context 'when only field name is given' do
      let(:options_hash) { { field_name: field_name } }

      it { expect(options.klass).to be_nil }
    end

    context 'when cast is a symbol' do
      let(:options_hash) { { field_name: field_name, cast: :string } }

      it 'returns the cast' do
        expect(options.klass).to eq(:string)
      end
    end

    context 'when cast is a Class' do
      let(:options_hash) { { field_name: field_name, cast: Baleog::Model } }

      it 'returns the cast' do
        expect(options.klass).to eq(Baleog::Model)
      end
    end

    context 'when cast is a string that does not represents a class' do
      let(:options_hash) { { field_name: field_name, cast: 'string' } }

      it 'returns the cast as symbol' do
        expect(options.klass).to eq(:string)
      end
    end

    context 'when cast is a string that represents a class' do
      let(:options_hash) { { field_name: field_name, cast: 'Baleog::Model' } }

      it 'returns the cast as Class' do
        expect(options.klass).to eq(Baleog::Model)
      end
    end
  end

  describe '#key_name' do
    context 'when only field name is given' do
      let(:options_hash) { { field_name: field_name } }

      it { expect(options.key_name).to eq(field_name.to_s) }
    end

    context 'when key is a symbol' do
      let(:options_hash) { { field_name: field_name, key: :some_key } }

      it 'returns the key in string' do
        expect(options.key_name).to eq('some_key')
      end
    end

    context 'when key is a string' do
      let(:options_hash) { { field_name: field_name, key: 'some_key' } }

      it 'returns the key' do
        expect(options.key_name).to eq('some_key')
      end
    end
  end
end
