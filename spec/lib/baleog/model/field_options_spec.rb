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
      let(:options_hash) { { field_name: field_name, cast: 'Baelog::Model' } }

      it 'returns the cast as symbol' do
        expect(options.klass).to eq(:string)
      end
    end
  end
end
