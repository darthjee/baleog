# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client::Model::FieldBuilder do
  let(:attributes) do
    {
      builder: builder,
      options: options,
      writter: writter_flag
    }.compact
  end
  let(:builder) { Baleog::Client::Model::Builder.new(model_class) }
  let(:options) { Baleog::Client::Model::FieldOptions.new(**options_hash) }
  let(:options_hash) do
    {
      field_name: field_name,
      key: key,
      cast: cast,
      caster_class: caster_class
    }.compact
  end

  let(:base_model_class) { Class.new(Baleog::Client::Model) }
  let(:model_class)      { Class.new(base_model_class) }
  let(:hash)             { { field_name: value } }
  let(:value)            { :value }
  let(:model)            { model_class.new(hash) }
  let(:writter_flag)     { nil }
  let(:key)              { nil }
  let(:cast)             { nil }
  let(:caster_class)     { model_class::ValueWrapper }

  describe '.add_methods' do
    let(:field_name) { :field_name }

    before do
      described_class.add_methods(**attributes)
    end

    context 'when no options are given' do
      it 'Adds a reader' do
        expect { builder.build }
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect { builder.build }
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the build is done' do
        before { builder.build }

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
      let(:key)        { :field_name }

      it 'Adds reader' do
        expect { builder.build }
          .to add_method(:field).to(model_class)
      end

      it 'does not add original name reader' do
        expect { builder.build }
          .not_to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect { builder.build }
          .to add_method(:field=).to(model_class)
      end

      it 'does not add original name writter' do
        expect { builder.build }
          .not_to add_method(:field_name=).to(model_class)
      end

      context 'when the build is done' do
        before { builder.build }

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
      let(:cast) { :string }

      it 'Adds reader' do
        expect { builder.build }
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect { builder.build }
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the build is done' do
        before { builder.build }

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
      let(:cast)           { other_model_class }

      let(:other_model_class) do
        Class.new(base_model_class) do
          field :key
        end
      end

      it 'Adds reader' do
        expect { builder.build }
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect { builder.build }
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the build is done' do
        before { builder.build }

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
