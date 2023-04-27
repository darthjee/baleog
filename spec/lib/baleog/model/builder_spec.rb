# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::Builder do
  subject(:builder) { described_class.new(model_class) }

  let(:model_class) { Class.new(Baleog::Model) }
  let(:hash)        { { field_name: :value } }
  let(:model)       { model_class.new(hash) }

  describe '.add_field' do
    context 'when no options are given' do
      let(:block) do
        proc do
          builder.add_field :field_name
          builder.build
        end
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the build is done' do
        before { block.call }

        it 'reads the value in the reader' do
          expect(model.field_name).to eq(:value)
        end

        it 'writtes the value in the writter' do
          expect { model.field_name = :new_value }
            .to change(model, :field_name)
            .from(:value).to(:new_value)
        end
      end
    end

    context 'when key is provided' do
      let(:block) do
        proc do
          builder.add_field :field, key: :field_name
          builder.build
        end
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field).to(model_class)
      end

      it 'does not add original name reader' do
        expect(&block)
          .not_to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field=).to(model_class)
      end

      it 'does not add original name writter' do
        expect(&block)
          .not_to add_method(:field_name=).to(model_class)
      end

      context 'when the build is done' do
        before { block.call }

        it 'reads the value in the reader' do
          expect(model.field).to eq(:value)
        end

        it 'writtes the value in the writter' do
          expect { model.field = :new_value }
            .to change(model, :field)
            .from(:value).to(:new_value)
        end
      end
    end
  end

  describe '.add_fields' do
    let(:block) do
      proc do
        builder.add_fields %i[field_name other_field]
        builder.build
      end
    end

    it 'Adds reader for the first field' do
      expect(&block)
        .to add_method(:field_name).to(model_class)
    end

    it 'Adds reader for the other field' do
      expect(&block)
        .to add_method(:other_field).to(model_class)
    end

    it 'Adds writter for the first field' do
      expect(&block)
        .to add_method(:field_name=).to(model_class)
    end

    it 'Adds writter for the other field' do
      expect(&block)
        .to add_method(:other_field=).to(model_class)
    end
  end
end
