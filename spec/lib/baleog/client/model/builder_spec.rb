# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client::Model::Builder do
  subject(:builder) { described_class.new(model_class) }

  let(:base_model_class) { Class.new(Baleog::Client::Model) }
  let(:model_class)      { Class.new(base_model_class) }
  let(:hash)             { { field_name: value } }
  let(:value)            { :value }
  let(:model)            { model_class.new(hash) }

  describe '.add_field' do
    let(:field_name) { :field_name }
    let(:block) do
      proc do
        builder.add_field(
          field_name: field_name, caster_class: model_class::ValueWrapper,
          **options
        )
        builder.build
      end
    end

    context 'when no options are given' do
      let(:options) { {} }

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

        it 'reads the value in the reader with casting' do
          expect(model.field_name).to eq(value)
        end

        it 'writtes the value in the writter' do
          expect { model.field_name = :new_value }
            .to change(model, :field_name)
            .from(value).to('new_value')
        end
      end
    end

    context 'when key is provided' do
      let(:field_name) { :field }
      let(:options)    { { key: :field_name } }

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
          expect(model.field).to eq(value)
        end

        it 'writtes the value in the writter' do
          expect { model.field = :new_value }
            .to change(model, :field)
            .from(value).to('new_value')
        end
      end
    end

    context 'when cast is given' do
      let(:options) { { cast: :string } }

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
          expect(model.field_name).to eq('value')
        end

        it 'writtes the value in the writter' do
          expect { model.field_name = :new_value }
            .to change(model, :field_name)
            .from('value').to('new_value')
        end
      end
    end

    context 'when cast model class is given' do
      let(:value)          { { key: some_value } }
      let(:new_value)      { { key: some_new_value } }
      let(:some_value)     { :some_value }
      let(:some_new_value) { :some_new_value }
      let(:options)        { { cast: other_model_class } }

      let(:other_model_class) do
        Class.new(base_model_class) do
          field :key
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

        it do
          expect(model.field_name)
            .to be_a(other_model_class)
        end

        it 'reads the value in the reader' do
          expect(model.field_name)
            .to eq(other_model_class.new(value))
        end

        it 'writtes the value in the writter' do
          expect { model.field_name = new_value }
            .to change(model, :field_name)
            .from(other_model_class.new(value))
            .to(other_model_class.new(new_value))
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
